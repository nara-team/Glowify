import 'package:get/get.dart';

class TutorialController extends GetxController {
  // Example categories
  final categories = <String>[
    'Skincare',
    'Makeup',
    'Hair Care',
    'Body Care',
    'Nail Art'
  ].obs;

  // Currently selected category
  final selectedCategory = ''.obs;

  // Dummy loading state
  final isLoading = false.obs;

  // Dummy error message
  final errorMessage = ''.obs;

  // Dummy data for news articles
  final newsArticles = <Article>[
    Article(title: 'Cara Memutihkan Kulit dengan Aman'),
    Article(title: 'Teknik Makeup untuk Pemula'),
    Article(title: 'Tips Merawat Rambut Agar Tidak Rontok'),
    Article(title: 'Panduan Skincare untuk Kulit Berminyak'),
    Article(title: 'Cara Membuat Nail Art yang Sederhana'),
    Article(title: 'Produk Skincare yang Wajib Dimiliki'),
    Article(title: 'Teknik Membentuk Alis yang Tepat'),
    Article(title: 'Cara Mencegah Jerawat dengan Skincare'),
    Article(title: 'Tips Memilih Foundation Sesuai Warna Kulit'),
    Article(title: 'Perawatan Tubuh untuk Kulit Lebih Cerah'),
  ].obs;

  // Function to search for news
  void searchNews(String query) {
    // Implement search logic here
  }
}

class Article {
  final String title;

  Article({required this.title});
}
