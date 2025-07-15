import 'package:flutter/material.dart';

class DetailRiwayatPage extends StatelessWidget {
  final String imageUrl;
  final String jenisBola;
  final String waktuDeteksi;

  const DetailRiwayatPage({
    Key? key,
    required this.imageUrl,
    required this.jenisBola,
    required this.waktuDeteksi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8E1FB),
        iconTheme: const IconThemeData(
          color: Color(0xFF2A32AA), // ✅ Back button warna biru
        ),
        title: const Text(
          'Detail Riwayat',
          style: TextStyle(
            color: Color(0xFF2A32AA),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.sports_soccer, color: Color(0xFF2A32AA)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    jenisBola,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A32AA),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.black54),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    waktuDeteksi,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
