import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'detail_riwayat_page.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  List<dynamic> riwayatFull = [];
  final int itemsPerPage = 7;
  int currentPage = 0;
  final String baseUrl = 'http://10.111.42.228:5000';

  @override
  void initState() {
    super.initState();
    fetchRiwayat();
  }

  String formatJenisBola(String jenis) {
    switch (jenis) {
      case 'no_ball':
        return 'Bola (basket/voli/kaki) tidak ditemukan';
      case 'volleyball':
        return 'Bola voli';
      case 'basketball':
        return 'Bola basket';
      case 'football':
        return 'Bola kaki';
      default:
        return jenis;
    }
  }

  List<dynamic> get paginatedItems {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, riwayatFull.length);
    return riwayatFull.sublist(startIndex, endIndex);
  }

  Future<void> fetchRiwayat() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/riwayat'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        setState(() {
          riwayatFull = jsonDecode(response.body);
        });
      } else {
        print('Gagal mengambil data riwayat');
      }
    } catch (e) {
      print('Error saat mengambil data: $e');
    }
  }

  Future<void> deleteRiwayat(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.delete(
        Uri.parse('$baseUrl/riwayat/$id'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        setState(() {
          riwayatFull.removeWhere((item) => item['id'] == id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus data'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _clearTokenAndGoToLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (riwayatFull.length / itemsPerPage).ceil();

    return WillPopScope(
      onWillPop: () async {
        await _clearTokenAndGoToLogin();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5),
              color: const Color(0xFFD8E1FB),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF2A32AA)),
                      onPressed: _clearTokenAndGoToLogin,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Riwayat Deteksi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A32AA),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: ListView.builder(
                itemCount: paginatedItems.length,
                itemBuilder: (context, index) {
                  final item = paginatedItems[index];
                  final imageUrl = '$baseUrl/uploads/${item['filename']}';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailRiwayatPage(
                            imageUrl: imageUrl,
                            jenisBola: formatJenisBola(item['jenis_bola'] ?? ''),
                            waktuDeteksi: item['waktu_deteksi'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF0D1D69)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 60);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatJenisBola(item['jenis_bola'] ?? ''),
                                  style: const TextStyle(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2A32AA),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  item['waktu_deteksi'] ?? '',
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Color.fromARGB(255, 128, 52, 47)),
                            onPressed: () => deleteRiwayat(item['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD8E1FB), 
                      foregroundColor: const Color(0xFF2A32AA), 
                    ),
                    onPressed: currentPage > 0
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                    child: const Text("Previous"),
                  ),
                  const SizedBox(width: 10),
                  Text("Halaman ${currentPage + 1} / $totalPages"),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD8E1FB),
                      foregroundColor: const Color(0xFF2A32AA),
                    ),
                    onPressed: currentPage < totalPages - 1
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
