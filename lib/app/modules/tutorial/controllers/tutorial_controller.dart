import 'package:get/get.dart';
import 'package:glowify/data/models/news_article.dart';
import 'package:glowify/data/provider/news_provider.dart';

class TutorialController extends GetxController {
  final NewsProvider newsProvider = NewsProvider();

  var allNewsArticles = <NewsArticle>[];
  var newsArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsArticles();
  }

  Future<void> fetchNewsArticles() async {
    try {
      isLoading(true);
      errorMessage('');
      final articles = await newsProvider.fetchNewsArticles();
      allNewsArticles = articles;
      newsArticles.assignAll(articles);
    } catch (e) {
      errorMessage('Failed to load news: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      newsArticles.assignAll(allNewsArticles);
    } else {
      newsArticles.assignAll(allNewsArticles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}

final List<String> categories = [
  'Skincare',
  'Makeup',
  'Hair Care',
  'Body Care',
  'Nail Art'
];
final RxString selectedCategory = 'Skincare'.obs;
