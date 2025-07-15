import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CaptureImagePage extends StatefulWidget {
  const CaptureImagePage({super.key});

  @override
  _CaptureImagePageState createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage> {
  File? _imageFile;
  String? _hasilPrediksi;
  String _waktuDeteksi = '';

  final Color primaryBlue = const Color(0xFF2A32AA);
  final Color lightBlue = const Color(0xFFB3C7F7);

  Future<void> _ambilGambar() async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
        await _kirimKeAPI(_imageFile!);
      }
    } catch (e) {
      print("Gagal membuka kamera: $e");
    }
  }

  Future<void> _kirimKeAPI(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.111.42.228:5000/predict'),
      );
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(await response.stream.bytesToString());
        setState(() {
          _hasilPrediksi = jsonData['jenis_bola'];
          _waktuDeteksi = DateTime.now().toString();
        });
      } else {
        setState(() {
          _hasilPrediksi = 'Deteksi gagal';
        });
      }
    } catch (e) {
      print("Gagal kirim ke API: $e");
    }
  }

  String tampilkanJenisBola(String jenisBola) {
    switch (jenisBola.toLowerCase()) {
      case 'no_ball':
        return 'Bola (basket/voli/kaki) tidak ditemukan';
      case 'volleyball':
        return 'Bola voli';
      case 'basketball':
        return 'Bola basket';
      case 'football':
        return 'Bola kaki';
      default:
        return 'Jenis bola: $jenisBola';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_imageFile == null && _hasilPrediksi == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFE7EDFC),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE7EDFC),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2A32AA)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Deteksi Capture Image",
            style: TextStyle(color: Color(0xFF2A32AA), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Center(
              child: ElevatedButton.icon(
                onPressed: _ambilGambar,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Ambil Gambar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
           
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/balls.png',
                  height: 220, 
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE7EDFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7EDFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2A32AA)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Deteksi dari Kamera",
          style: TextStyle(color: Color(0xFF2A32AA), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tombol ambil gambar
            Center(
              child: ElevatedButton.icon(
                onPressed: _ambilGambar,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Ambil Gambar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Gambar dari kamera
            if (_imageFile != null)
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: lightBlue),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_imageFile!, fit: BoxFit.cover),
                ),
              ),

            const SizedBox(height: 24),

            // Hasil prediksi
            if (_hasilPrediksi != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: lightBlue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hasil Deteksi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A32AA),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      tampilkanJenisBola(_hasilPrediksi!),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Waktu Deteksi: $_waktuDeteksi",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 48), 

            Image.asset(
              'assets/images/balls.png',
              height: 220, 
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
