import 'package:flutter/material.dart';
import 'package:ball_tect_app/capture_page.dart';
import 'package:ball_tect_app/live_detection.dart';
import 'package:ball_tect_app/upload_file_page.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final Color defaultColor = const Color.fromARGB(255, 218, 229, 255);
  final Color activeColor = const Color(0xFF2A32AA);
  final Color buttonTextBlue = const Color(0xFF003366);

  bool isUploadActive = false;
  bool isRealtimeActive = false;
  bool isCaptureActive = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFE7EDFC),
              width: double.infinity,
              child: Row(
                children: const [
                  Icon(Icons.sports_baseball, size: 40, color: Color(0xFF2A32AA)),
                  SizedBox(width: 10),
                  Text(
                    'Tect Ball',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2A32AA),
                    ),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Text(
                'Halo, selamat datang di Tect Ball! aplikasi yang mampu mengenali jenis bola hanya melalui kamera kamu.\n\nTunggu apa lagi? ayo deteksi jenis bola kamu 😎',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isUploadActive = true;
                        isRealtimeActive = false;
                        isCaptureActive = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UploadFilePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUploadActive ? activeColor : defaultColor,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Upload Gambar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isUploadActive ? Colors.white : buttonTextBlue,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isUploadActive = false;
                              isRealtimeActive = true;
                              isCaptureActive = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LiveDetectionPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isRealtimeActive ? activeColor : defaultColor,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Deteksi Realtime",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isRealtimeActive ? Colors.white : buttonTextBlue,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isUploadActive = false;
                              isRealtimeActive = false;
                              isCaptureActive = true;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CaptureImagePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isCaptureActive ? activeColor : defaultColor,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Capture Image",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isCaptureActive ? Colors.white : buttonTextBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            // JUDUL CARD
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Seputar Olahraga",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A32AA),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Card BASKET
            _buildSportCard(
              image: 'assets/images/basket.jpg',
              quote:
                  '"Di lapangan berukuran 28x15 meter, cerita tentang semangat, persaingan, dan kebersamaan tercipta setiap detiknya. Itulah dunia basket."',
            ),

            const SizedBox(height: 16),

            // Card SEPAK BOLA
            _buildSportCard(
              image: 'assets/images/football.jpg',
              quote:
                  'Keringat, strategi, dan kerja sama tim berpadu di setiap pertandingan — itulah yang membuat sepak bola menjadi olahraga paling digemari di seluruh dunia.',
            ),

            const SizedBox(height: 16),

            // Card VOLI
            _buildSportCard(
              image: 'assets/images/volleyball.jpg',
              quote:
                  'Dengan satu servis melambung tinggi dan smash yang mematikan, bola voli menyajikan aksi cepat dan kerja tim yang luar biasa di setiap setnya.',
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSportCard({required String image, required String quote}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: const Color(0xFFF5F7FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFB3C7F7)),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  quote,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
