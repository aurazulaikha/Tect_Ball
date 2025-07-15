import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveDetectionPage extends StatefulWidget {
  const LiveDetectionPage({super.key});

  @override
  State<LiveDetectionPage> createState() => _LiveDetectionPageState();
}

class _LiveDetectionPageState extends State<LiveDetectionPage> {
  CameraController? _controller;
  bool _isDetecting = false;
  String? _hasilPrediksi;
  Timer? _timer;
  String _waktuDeteksi = '';

  final Color primaryBlue = const Color(0xFF2A32AA);
  final Color lightBlue = const Color(0xFFB3C7F7);
  final Color textBlue = const Color(0xFF003366);

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
    await _controller!.setFlashMode(FlashMode.off);
    setState(() {});

    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _ambilDanKirimFrame());
  }

  Future<void> _ambilDanKirimFrame() async {
    if (_controller == null || !_controller!.value.isInitialized || _isDetecting) return;

    try {
      _isDetecting = true;
      final XFile file = await _controller!.takePicture();
      File imageFile = File(file.path);
      _waktuDeteksi = DateTime.now().toString();
      await _kirimKeAPI(imageFile);
    } catch (e) {
      print("Error saat ambil frame: $e");
    } finally {
      _isDetecting = false;
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
        return 'Jenis Bola: $jenisBola';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          "Deteksi Realtime",
          style: TextStyle(color: Color(0xFF2A32AA), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: (_controller == null || !_controller!.value.isInitialized)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: lightBlue),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CameraPreview(_controller!),
                      ),
                    ),
                    const SizedBox(height: 24),
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
                            _hasilPrediksi != null
                                ? tampilkanJenisBola(_hasilPrediksi!)
                                : "Sedang mendeteksi...",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _hasilPrediksi != null ? "Waktu Deteksi: $_waktuDeteksi" : "",
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Gambar bola di bawah hasil deteksi
                    Image.asset(
                      'assets/images/balls.png',
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
