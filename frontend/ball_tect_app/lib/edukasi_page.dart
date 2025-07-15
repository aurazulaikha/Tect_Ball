import 'package:flutter/material.dart';
import 'package:ball_tect_app/edukasi_detail_page.dart';

class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  // Warna konstan
  static const Color primaryColor = Color(0xFF2A32AA);
  static const Color cardBorderColor = Color(0xFFB3C7F7);
  static const Color cardBackgroundColor = Color(0xFFF5F7FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7EDFC),
        title: const Text(
          'Edukasi',
          style: TextStyle(
            fontSize: 20,
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            context,
            title: "Basket",
            quote:
                "“Di lapangan berukuran 28x15 meter, cerita tentang semangat, persaingan, dan kebersamaan tercipta setiap detiknya. Itulah dunia basket.”",
            image: "assets/images/basket.jpg",
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: "Sepak Bola",
            quote:
                "“Keringat, strategi, dan kerja sama tim berpadu di setiap pertandingan — itulah yang membuat sepak bola menjadi olahraga paling digemari di seluruh dunia.”",
            image: "assets/images/football.jpg",
          ),
          const SizedBox(height: 16),
          _buildCard(
            context,
            title: "Voli",
            quote:
                "“Dengan satu servis melambung tinggi dan smash yang mematikan, bola voli menyajikan aksi cepat dan kerja tim yang luar biasa di setiap setnya.”",
            image: "assets/images/volleyball.jpg",
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String quote,
    required String image,
  }) {
    return Card(
      color: cardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: cardBorderColor),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Kiri: Teks
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    quote,
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EdukasiDetailPage(
                            title: title,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "penasaran?",
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Kanan: Gambar
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
