import 'package:flutter/material.dart';

class EdukasiDetailPage extends StatelessWidget {
  final String title;

  const EdukasiDetailPage({
    super.key,
    required this.title,
  });

  static const Color primaryColor = Color(0xFF2A32AA);

  @override
  Widget build(BuildContext context) {
    final content = _getContentByTitle(title);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7EDFC),
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content['image'] != null)
              Center(
                child: Image.asset(
                  content['image'],
                  width: 200,
                  height: 200,
                ),
              ),
            const SizedBox(height: 24),
            for (var section in content['sections']) ...[
              _buildSectionTitle(section['title']),
              if (section.containsKey('text'))
                _buildParagraph(section['text']),
              if (section.containsKey('list'))
                _buildBulletList(List<String>.from(section['list'])),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.5),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("• ", style: TextStyle(fontSize: 14)),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Map<String, dynamic> _getContentByTitle(String title) {
    switch (title) {
      case "Basket":
        return {
          "image": "assets/images/basket.jpg",
          "sections": [
            {
              "title": "Deskripsi",
              "text":
                  "Olahraga basket adalah permainan bola besar yang dimainkan oleh dua tim, masing-masing terdiri dari lima pemain. "
                  "Tujuan dari permainan ini adalah mencetak poin sebanyak-banyaknya dengan cara memasukkan bola ke dalam ring (keranjang) lawan. "
                  "Permainan ini mengandalkan kecepatan, kelincahan, kerja sama tim, dan strategi.",
            },
            {
              "title": "Sejarah",
              "text":
                  "Bola basket pertama kali diciptakan oleh Dr. James Naismith pada tahun 1891 di Springfield, Massachusetts, Amerika Serikat. "
                  "Awalnya, basket dimainkan di dalam ruangan sebagai alternatif olahraga musim dingin. "
                  "Seiring waktu, permainan ini berkembang pesat dan menjadi salah satu olahraga paling populer di dunia.",
            },
            {
              "title": "Aturan Permainan",
              "list": [
                "Permainan terdiri dari dua tim yang masing-masing berusaha mencetak poin ke ring lawan.",
                "Bola dimainkan dengan tangan, baik dengan menggiring (dribble) maupun mengoper.",
                "Pemain tidak boleh berjalan atau berlari sambil memegang bola tanpa menggiring.",
                "Kontak fisik yang keras atau pelanggaran lainnya bisa menyebabkan pelanggaran atau free throw.",
                "Tim dengan skor terbanyak di akhir permainan menjadi pemenang."
              ]
            },
            {
              "title": "Jumlah Pemain",
              "list": [
                "Lima pemain utama di lapangan untuk setiap tim.",
                "Cadangan maksimal 7 pemain (total 12 pemain).",
                "Pergantian pemain bebas saat bola mati.",
              ]
            },
            {
              "title": "Ukuran Lapangan",
              "list": [
                "Panjang: 28 meter",
                "Lebar: 15 meter",
                "Tinggi ring: 3,05 meter",
                "Diameter ring: 45 cm",
                "Garis tiga poin: sekitar 6,75 meter (internasional)",
              ]
            },
            {
              "title": "Waktu Permainan",
              "list": [
                "4 kuarter (babak) per pertandingan.",
                "Durasi 10 menit per kuarter (internasional) atau 12 menit (NBA).",
                "Istirahat 2 menit antar kuarter, dan 15 menit saat half-time.",
                "Overtime 5 menit jika skor imbang.",
              ]
            },
            {
              "title": "Spesifikasi Alat dan Perlengkapan",
              "list": [
                "Bola basket — kulit/sintetis, keliling 75 cm, berat 600–650 gram.",
                "Ring basket — besi dengan jaring.",
                "Papan pantul — akrilik/kaca temper ukuran 1,80 m x 1,05 m.",
                "Seragam — jersey tanpa lengan, celana pendek, sepatu basket.",
              ]
            }
          ]
        };

      case "Sepak Bola":
        return {
          "image": "assets/images/football.jpg",
          "sections": [
            {
              "title": "Deskripsi",
              "text":
                  "Sepak bola adalah olahraga tim yang dimainkan oleh dua tim masing-masing beranggotakan 11 pemain. Tujuannya adalah mencetak gol sebanyak mungkin ke gawang lawan dengan bola bundar di lapangan rumput.",
            },
            {
              "title": "Sejarah",
              "text":
                  "Sepak bola modern berkembang di Inggris pada abad ke-19 dan sejak saat itu menjadi olahraga paling populer di dunia. FIFA sebagai badan internasional mengatur turnamen seperti Piala Dunia sejak 1930.",
            },
            {
              "title": "Aturan Permainan",
              "list": [
                "Dua tim masing-masing 11 pemain termasuk penjaga gawang.",
                "Pertandingan berlangsung selama 2 x 45 menit dengan istirahat 15 menit.",
                "Gol tercipta jika bola melewati garis gawang lawan sepenuhnya.",
                "Pelanggaran bisa menghasilkan tendangan bebas, penalti, kartu kuning atau merah.",
              ]
            },
            {
              "title": "Jumlah Pemain",
              "list": [
                "11 pemain utama (termasuk 1 kiper).",
                "Cadangan maksimal 12 (bergantung regulasi).",
                "5 pergantian pemain diperbolehkan dalam pertandingan resmi.",
              ]
            },
            {
              "title": "Ukuran Lapangan",
              "list": [
                "Panjang: 100 - 110 meter",
                "Lebar: 64 - 75 meter",
                "Diameter lingkaran tengah: 9.15 meter",
                "Tinggi gawang: 2.44 meter, lebar: 7.32 meter",
              ]
            },
            {
              "title": "Waktu Permainan",
              "list": [
                "2 babak masing-masing 45 menit.",
                "Tambahan waktu (injury time) sesuai keputusan wasit.",
                "Jika imbang dalam turnamen bisa lanjut ke perpanjangan waktu 2x15 menit atau adu penalti.",
              ]
            },
            {
              "title": "Spesifikasi Alat dan Perlengkapan",
              "list": [
                "Bola kulit atau sintetis, keliling 68–70 cm.",
                "Gawang dengan jaring.",
                "Seragam terdiri dari jersey, celana pendek, kaos kaki, pelindung tulang kering, dan sepatu bola.",
              ]
            },
          ]
        };

      case "Voli":
        return {
          "image": "assets/images/volleyball.jpg",
          "sections": [
            {
              "title": "Deskripsi",
              "text":
                  "Bola voli adalah olahraga tim yang dimainkan oleh dua tim, masing-masing terdiri dari enam pemain. Tujuan permainan ini adalah agar bola menyentuh lantai lapangan lawan sambil mencegah bola jatuh di area sendiri.",
            },
            {
              "title": "Sejarah",
              "text":
                  "Bola voli diciptakan oleh William G. Morgan pada tahun 1895 di Amerika Serikat. Awalnya bernama 'mintonette' dan kini menjadi olahraga populer di Olimpiade dan seluruh dunia.",
            },
            {
              "title": "Aturan Permainan",
              "list": [
                "Satu tim memiliki maksimal tiga kali sentuhan sebelum mengembalikan bola.",
                "Tidak boleh menyentuh net saat permainan berlangsung.",
                "Servis dilakukan dari belakang garis lapangan.",
                "Pertandingan terdiri dari 3 atau 5 set.",
              ]
            },
            {
              "title": "Jumlah Pemain",
              "list": [
                "6 pemain di lapangan per tim.",
                "Cadangan dapat mencapai 6 pemain tambahan.",
                "Rotasi posisi saat tim mendapatkan giliran servis.",
              ]
            },
            {
              "title": "Ukuran Lapangan",
              "list": [
                "Panjang: 18 meter",
                "Lebar: 9 meter",
                "Tinggi net: 2.43 meter (pria), 2.24 meter (wanita)",
              ]
            },
            {
              "title": "Waktu Permainan",
              "list": [
                "Tidak ada durasi tetap per set.",
                "Satu set dimenangkan tim pertama yang mencapai 25 poin dengan selisih 2 poin.",
                "Jika permainan mencapai set ke-5 (penentuan), hanya sampai 15 poin.",
              ]
            },
            {
              "title": "Spesifikasi Alat dan Perlengkapan",
              "list": [
                "Bola voli — keliling 65–67 cm, berat 260–280 gram.",
                "Net — tinggi sesuai kategori gender.",
                "Seragam — jersey, celana pendek, pelindung lutut, dan sepatu voli.",
              ]
            }
          ]
        };

      default:
        return {
          "image": null,
          "sections": [
            {
              "title": "Konten Tidak Ditemukan",
              "text": "Konten edukasi belum tersedia untuk $title.",
            }
          ]
        };
    }
  }
}
