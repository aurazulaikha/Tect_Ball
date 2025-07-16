import tensorflow as tf
import os
from PIL import Image

# Daftar folder yang ingin dicek
DATASET_DIRS = ['dataset/train', 'dataset/test']

checked_files = 0
deleted_files = 0

for dataset_dir in DATASET_DIRS:
    print(f"\nMemeriksa folder: {dataset_dir}")
    for root, dirs, files in os.walk(dataset_dir):
        for file in files:
            file_path = os.path.join(root, file)
            checked_files += 1
            try:
                # Coba buka dengan PIL
                with Image.open(file_path) as img:
                    img.verify()
                # Decode dengan TensorFlow
                image_data = tf.io.read_file(file_path)
                _ = tf.image.decode_image(image_data)
            except Exception as e:
                print(f"[INVALID] {file_path} - Error: {e}")
                try:
                    os.remove(file_path)
                    print(f"[DELETED] {file_path}")
                    deleted_files += 1
                except Exception as delete_error:
                    print(f"[FAILED TO DELETE] {file_path} - {delete_error}")

print("\nSelesai.")
print(f"Total file dicek: {checked_files}")
print(f"Total file dihapus: {deleted_files}")
