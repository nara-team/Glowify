import 'package:get/get.dart';
import 'package:glowify/data/models/news_article.dart';
import 'package:glowify/data/provider/news_provider.dart';

class TutorialController extends GetxController {
  final NewsProvider newsProvider = NewsProvider();

  var allNewsArticles =
      <NewsArticle>[]; // To store all articles loaded from API
  var newsArticles = <NewsArticle>[].obs; // To store filtered articles
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsArticles(); // Load initial news articles
  }

  Future<void> fetchNewsArticles() async {
    try {
      isLoading(true);
      errorMessage(''); // Clear any previous error messages
      final articles = await newsProvider.fetchNewsArticles();
      allNewsArticles = articles; // Store all articles
      newsArticles.assignAll(articles); // Initially, all articles are shown
    } catch (e) {
      errorMessage('Failed to load news: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      newsArticles.assignAll(
          allNewsArticles); // Reset to all articles if query is empty
    } else {
      newsArticles.assignAll(allNewsArticles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }
}

final List<String> categories = ['Komedo', 'Jerawat', 'Kulit', 'Kutil', '10 +'];
final RxString selectedCategory = 'Komedo'.obs;
