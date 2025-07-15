from flask import Flask, request, jsonify, send_from_directory
import numpy as np
import tensorflow as tf
from PIL import Image
import io
import datetime
import mysql.connector
from werkzeug.utils import secure_filename
import os
import jwt
import bcrypt
from functools import wraps

app = Flask(__name__)

# Konfigurasi database
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'ball_tect'
}

# Konfigurasi JWT
JWT_SECRET = 'Bismillah_bisa'
JWT_ALGORITHM = 'HS256'
JWT_EXPIRE_MINUTES = 60

# Folder upload gambar dengan path absolut
UPLOAD_FOLDER = os.path.abspath('D:/SEMESTER 6/Capstone/ball/uploads')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# Load model TFLite
interpreter = tf.lite.Interpreter(model_path="models/bola_detector.tflite")
interpreter.allocate_tensors()
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Label klasifikasi
label_mapping = ['basketball', 'football', 'no_ball', 'volleyball']

@app.route('/')
def home():
    return 'Hi, Aura!'

# Preprocessing gambar
def preprocess(image_bytes):
    img = Image.open(io.BytesIO(image_bytes)).convert('RGB')
    img = img.resize((224, 224))
    img_array = np.array(img).astype(np.float32) / 255.0
    return img_array

# Simpan hasil deteksi ke database
def simpan_ke_database(jenis_bola, waktu_deteksi, filename):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        query = "INSERT INTO riwayat_deteksi (jenis_bola, waktu_deteksi, filename) VALUES (%s, %s, %s)"
        cursor.execute(query, (jenis_bola, waktu_deteksi, filename))
        conn.commit()
        cursor.close()
        conn.close()
    except mysql.connector.Error as err:
        print("MySQL Error:", err)

# Middleware token
def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        if 'Authorization' in request.headers:
            bearer = request.headers['Authorization']
            token = bearer.split(" ")[1] if " " in bearer else bearer

        if not token:
            return jsonify({'error': 'Token tidak ditemukan'}), 401

        try:
            data = jwt.decode(token, JWT_SECRET, algorithms=[JWT_ALGORITHM])
            request.user = data
        except jwt.ExpiredSignatureError:
            return jsonify({'error': 'Token kadaluarsa'}), 401
        except jwt.InvalidTokenError:
            return jsonify({'error': 'Token tidak valid'}), 401

        return f(*args, **kwargs)
    return decorated

# Endpoint login admin
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({'error': 'Username dan password diperlukan'}), 400

    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM admin WHERE username = %s", (username,))
        admin = cursor.fetchone()
        cursor.close()
        conn.close()

        if admin and bcrypt.checkpw(password.encode(), admin['password'].encode()):
            payload = {
                'id': admin['id'],
                'username': admin['username'],
                'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=JWT_EXPIRE_MINUTES)
            }
            token = jwt.encode(payload, JWT_SECRET, algorithm=JWT_ALGORITHM)
            return jsonify({'token': token})
        else:
            return jsonify({'error': 'Username atau password salah'}), 401

    except mysql.connector.Error as err:
        return jsonify({'error': f'MySQL error: {err}'}), 500

# Endpoint deteksi bola
@app.route('/predict', methods=['POST'])
def predict():
    if 'image' not in request.files:
        return jsonify({'error': 'No image file provided'}), 400

    file = request.files['image']
    if file and file.filename.lower().endswith(('png', 'jpg', 'jpeg')):
        filename = secure_filename(file.filename)
        save_path = os.path.join(UPLOAD_FOLDER, filename)
        file.save(save_path)

        with open(save_path, 'rb') as img_file:
            img_array = preprocess(img_file.read())

        input_data = np.expand_dims(img_array, axis=0)
        interpreter.set_tensor(input_details[0]['index'], input_data)
        interpreter.invoke()
        prediction = interpreter.get_tensor(output_details[0]['index'])

        label_idx = int(np.argmax(prediction))
        jenis_bola = label_mapping[label_idx]
        waktu = datetime.datetime.now()

        simpan_ke_database(jenis_bola, waktu, filename)

        return jsonify({
            'jenis_bola': jenis_bola,
            'waktu': waktu.isoformat(),
            'filename': filename,
            'detections': [{
                'label': jenis_bola,
                'bounds': {'left': 50, 'top': 50, 'right': 200, 'bottom': 200}
            }]
        })
    else:
        return jsonify({'error': 'Invalid file format. Only PNG, JPG, JPEG allowed.'}), 400

# Endpoint riwayat (GET) - admin only
@app.route('/riwayat', methods=['GET'])
@token_required
def get_riwayat():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, jenis_bola, waktu_deteksi, filename FROM riwayat_deteksi ORDER BY waktu_deteksi DESC")
        results = cursor.fetchall()
        cursor.close()
        conn.close()

        # Tambahkan URL absolut agar bisa diakses dari Flutter
        for row in results:
            row['image_url'] = f"http://10.111.42.228:5000/uploads/{row['filename']}"

        return jsonify(results)
    except mysql.connector.Error as err:
        return jsonify({'error': f'MySQL error: {err}'}), 500

# Endpoint riwayat (DELETE) - admin only
@app.route('/riwayat/<int:id>', methods=['DELETE'])
@token_required
def delete_riwayat(id):
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        cursor.execute("SELECT filename FROM riwayat_deteksi WHERE id = %s", (id,))
        result = cursor.fetchone()

        if not result:
            return jsonify({'error': 'Data tidak ditemukan'}), 404

        filename = result[0]
        cursor.execute("DELETE FROM riwayat_deteksi WHERE id = %s", (id,))
        conn.commit()
        cursor.close()
        conn.close()

        file_path = os.path.join(UPLOAD_FOLDER, filename)
        if os.path.exists(file_path):
            os.remove(file_path)

        return jsonify({'message': f'Riwayat dengan ID {id} berhasil dihapus.'})
    except mysql.connector.Error as err:
        return jsonify({'error': f'MySQL error: {err}'}), 500

# Endpoint untuk akses gambar
@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)

# Jalankan server
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
