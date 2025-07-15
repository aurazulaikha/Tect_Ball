import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadFilePage extends StatefulWidget {
  const UploadFilePage({super.key});

  @override
  State<UploadFilePage> createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  File? _image;
  String? _jenisBola;
  String _waktuDeteksi = '';
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  final Color primaryBlue = const Color(0xFF2A32AA);
  final Color lightBlue = const Color(0xFFB3C7F7);

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _jenisBola = null;
        _waktuDeteksi = '';
        _isLoading = true;
      });

      await _uploadAndDetect();
    }
  }

  Future<void> _uploadAndDetect() async {
    if (_image == null) return;

    final uri = Uri.parse("http://10.111.42.228:5000/predict"); 
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);

        setState(() {
          _jenisBola = data['jenis_bola'];
          _waktuDeteksi = DateTime.now().toString();
          _isLoading = false;
        });
      } else {
        setState(() {
          _jenisBola = "Terjadi kesalahan. Status: ${response.statusCode}";
          _waktuDeteksi = '';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _jenisBola = "Terjadi kesalahan koneksi: $e";
        _waktuDeteksi = '';
        _isLoading = false;
      });
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
    // Halaman saat belum ada gambar dan hasil deteksi
    if (_image == null && _jenisBola == null) {
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
            'Upload Gambar',
            style: TextStyle(color: Color(0xFF2A32AA), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Center(
              child: ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload_file),
                label: const Text('Pilih Gambar'),
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
          'Upload Gambar',
          style: TextStyle(color: Color(0xFF2A32AA), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _pickImage,
              icon: const Icon(Icons.upload_file),
              label: const Text('Pilih Gambar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            if (_isLoading) const CircularProgressIndicator(),

            if (_image != null)
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: lightBlue),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, fit: BoxFit.cover),
                ),
              ),

            const SizedBox(height: 24),

            if (_jenisBola != null)
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
                      'Hasil Deteksi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A32AA),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      tampilkanJenisBola(_jenisBola!),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Waktu Deteksi: $_waktuDeteksi',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 48),

            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/balls.png',
                height: 220,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
