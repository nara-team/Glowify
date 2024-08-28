import 'package:flutter/material.dart';

class TreatmentRecommendation extends StatelessWidget {
  final List<String> results;

  const TreatmentRecommendation({
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    String recommendation = _generateRecommendation();
    List<Widget> productRecommendations = _generateProductRecommendations();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rekomendasi Perawatan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          recommendation,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        Text(
          'Rekomendasi Produk',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 220, // Sesuaikan tinggi kontainer sesuai kebutuhan
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: productRecommendations,
          ),
        ),
      ],
    );
  }

  String _generateRecommendation() {
    bool dahiSehat = results[0] == "Sehat";
    bool pipiSehat = results[1] == "Sehat";
    bool hidungSehat = results[2] == "Sehat";

    if (dahiSehat && pipiSehat && hidungSehat) {
      return '''
        Kulit Anda tampak sehat di seluruh area. Untuk menjaga kesehatan kulit secara umum, lakukan pembersihan wajah lembut dua kali sehari. Eksfoliasi kulit 1-2 kali seminggu untuk menjaga kebersihan pori-pori dan mencegah penumpukan sel kulit mati. Gunakan pelembap yang sesuai dengan jenis kulit Anda untuk menjaga kelembapan. Aplikasikan sunscreen setiap pagi untuk melindungi kulit dari sinar UV.
      ''';
    } else if (!dahiSehat && pipiSehat && hidungSehat) {
      return '''
        Dahi Anda menunjukkan tanda-tanda ketidaksehatan. Untuk mengatasi masalah ini, gunakan pembersih wajah anti-akne yang dapat membantu mengurangi jerawat atau minyak berlebih di dahi. Pertimbangkan untuk menggunakan serum dengan niacinamide yang dapat memperbaiki tekstur kulit dan mengurangi jerawat. Eksfoliasi area dahi secara teratur untuk mencegah penumpukan sel kulit mati.
      ''';
    } else if (dahiSehat && !pipiSehat && hidungSehat) {
      return '''
        Pipi Anda memerlukan perhatian khusus. Gunakan pembersih yang mengandung bahan anti-inflamasi jika kulit Anda kemerahan atau iritasi. Pertimbangkan untuk menggunakan pelembap dengan bahan menenangkan seperti aloe vera atau chamomile yang dapat membantu mengurangi iritasi dan menjaga kelembapan kulit.
      ''';
    } else if (dahiSehat && pipiSehat && !hidungSehat) {
      return '''
        Hidung Anda menunjukkan tanda-tanda ketidaksehatan. Gunakan pembersih yang menargetkan pori-pori tersumbat dan minyak berlebih. Eksfoliasi area hidung secara teratur untuk mencegah komedo dan menjaga kebersihan pori-pori.
      ''';
    } else if (!dahiSehat && !pipiSehat && hidungSehat) {
      return '''
        Dahi dan pipi Anda menunjukkan tanda-tanda ketidaksehatan. Untuk dahi, gunakan pembersih wajah anti-akne dan serum dengan niacinamide. Untuk pipi, gunakan pembersih dengan bahan anti-inflamasi dan pelembap menenangkan. Pastikan untuk merawat kulit secara konsisten dan melindungi dari iritasi lebih lanjut. Jika diperlukan, konsultasikan dengan ahli kulit.
      ''';
    } else if (!dahiSehat && hidungSehat && !pipiSehat) {
      return '''
        Dahi dan pipi Anda memerlukan perhatian khusus. Gunakan pembersih wajah yang sesuai untuk mengatasi masalah di dahi dan pipi. Untuk dahi, gunakan pembersih anti-akne dan serum dengan niacinamide. Untuk pipi, gunakan pembersih anti-inflamasi dan pelembap menenangkan. Konsultasikan dengan ahli kulit jika masalah berlanjut.
      ''';
    } else if (dahiSehat && !pipiSehat && !hidungSehat) {
      return '''
        Pipi dan hidung Anda menunjukkan ketidaksehatan. Untuk pipi, gunakan pembersih anti-inflamasi dan pelembap menenangkan. Untuk hidung, gunakan pembersih yang menargetkan pori-pori tersumbat dan eksfoliasi secara teratur. Pastikan untuk menjaga kelembapan kulit dan konsultasikan dengan ahli kulit jika diperlukan.
      ''';
    } else {
      return '''
        Semua area wajah Anda menunjukkan ketidaksehatan. Kami sangat menyarankan Anda untuk berkonsultasi dengan ahli kulit untuk mendapatkan rekomendasi perawatan yang lebih spesifik dan sesuai dengan kondisi kulit Anda. Perawatan khusus mungkin diperlukan untuk mengatasi masalah di seluruh area wajah.
      ''';
    }
  }

  List<Widget> _generateProductRecommendations() {
    bool dahiSehat = results[0] == "Sehat";
    bool pipiSehat = results[1] == "Sehat";
    bool hidungSehat = results[2] == "Sehat";

    if (dahiSehat && pipiSehat && hidungSehat) {
      return [
        _buildProductCard(
          'Krim Pelembap SPF',
          'Mengandung SPF 30 untuk melindungi kulit dari sinar UV.',
          'assets/cream.jpg',
          () => print('Krim Pelembap SPF tapped'),
        ),
        _buildProductCard(
          'Eksfoliasi Lembut',
          'Scrub lembut dengan bahan alami untuk mengangkat sel kulit mati.',
          'assets/exfoliator.jpg',
          () => print('Eksfoliasi Lembut tapped'),
        ),
      ];
    } else if (!dahiSehat && pipiSehat && hidungSehat) {
      return [
        _buildProductCard(
          'Pembersih Anti-Akne',
          'Mengandung asam salisilat untuk mengurangi jerawat.',
          'assets/acne_cleanser.jpg',
          () => print('Pembersih Anti-Akne tapped'),
        ),
        _buildProductCard(
          'Serum Niacinamide',
          'Memperbaiki tekstur kulit dan mengurangi minyak berlebih.',
          'assets/niacinamide_serum.jpg',
          () => print('Serum Niacinamide tapped'),
        ),
      ];
    } else if (dahiSehat && !pipiSehat && hidungSehat) {
      return [
        _buildProductCard(
          'Pembersih Anti-Inflamasi',
          'Mengandung chamomile untuk menenangkan kulit.',
          'assets/anti_inflammatory_cleanser.jpg',
          () => print('Pembersih Anti-Inflamasi tapped'),
        ),
        _buildProductCard(
          'Pelembap Aloe Vera',
          'Menghidrasi dan menenangkan iritasi kulit.',
          'assets/aloe_vera_moisturizer.jpg',
          () => print('Pelembap Aloe Vera tapped'),
        ),
      ];
    } else if (dahiSehat && pipiSehat && !hidungSehat) {
      return [
        _buildProductCard(
          'Pembersih Pori',
          'Mengandung charcoal untuk membersihkan pori-pori.',
          'assets/charcoal_cleanser.jpg',
          () => print('Pembersih Pori tapped'),
        ),
        _buildProductCard(
          'Eksfoliasi Komedo',
          'Scrub yang dirancang khusus untuk mengurangi komedo.',
          'assets/comedo_exfoliator.jpg',
          () => print('Eksfoliasi Komedo tapped'),
        ),
      ];
    } else if (!dahiSehat && !pipiSehat && hidungSehat) {
      return [
        _buildProductCard(
          'Pembersih Anti-Akne',
          'Diformulasikan untuk mengurangi jerawat di dahi dan pipi.',
          'assets/acne_cleanser.jpg',
          () => print('Pembersih Anti-Akne tapped'),
        ),
        _buildProductCard(
          'Serum Niacinamide',
          'Menyeimbangkan produksi minyak dan memperbaiki tekstur kulit.',
          'assets/niacinamide_serum.jpg',
          () => print('Serum Niacinamide tapped'),
        ),
      ];
    } else if (!dahiSehat && hidungSehat && !pipiSehat) {
      return [
        _buildProductCard(
          'Pembersih Anti-Akne',
          'Mengatasi masalah jerawat di dahi dan pipi.',
          'assets/acne_cleanser.jpg',
          () => print('Pembersih Anti-Akne tapped'),
        ),
        _buildProductCard(
          'Pelembap Menenangkan',
          'Menjaga kelembapan kulit dan mengurangi iritasi.',
          'assets/soothing_moisturizer.jpg',
          () => print('Pelembap Menenangkan tapped'),
        ),
      ];
    } else if (dahiSehat && !pipiSehat && !hidungSehat) {
      return [
        _buildProductCard(
          'Pembersih Anti-Inflamasi',
          'Mengatasi kemerahan dan iritasi di pipi.',
          'assets/anti_inflammatory_cleanser.jpg',
          () => print('Pembersih Anti-Inflamasi tapped'),
        ),
        _buildProductCard(
          'Eksfoliasi Lembut',
          'Menjaga kebersihan pori dan mencegah penumpukan sel kulit mati.',
          'assets/exfoliator.jpg',
          () => print('Eksfoliasi Lembut tapped'),
        ),
      ];
    } else {
      return [
        _buildProductCard(
          'Pembersih Lengkap',
          'Mengatasi berbagai masalah kulit dengan formula lengkap.',
          'assets/complete_cleanser.jpg',
          () => print('Pembersih Lengkap tapped'),
        ),
        _buildProductCard(
          'Serum Semua Masalah',
          'Diformulasikan untuk berbagai jenis masalah kulit.',
          'assets/all_problem_serum.jpg',
          () => print('Serum Semua Masalah tapped'),
        ),
      ];
    }
  }

  Widget _buildProductCard(String productName, String productDescription,
      String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mengatur ukuran gambar
            Container(
              height: 120, // Menentukan tinggi gambar
              width: double
                  .infinity, // Memastikan lebar gambar mengikuti lebar card
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Menjaga aspek rasio gambar
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Menyusun nama produk
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Menyusun deskripsi produk
                  Text(
                    productDescription,
                    style: TextStyle(fontSize: 14),
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
