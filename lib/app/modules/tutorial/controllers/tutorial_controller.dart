import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowify/data/models/news_article.dart';
import 'package:glowify/data/provider/news_provider.dart';

class TutorialController extends GetxController {
  final NewsProvider newsProvider = NewsProvider();
  var newsArticles = <NewsArticle>[].obs;
  var filteredArticles = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  final List<String> categories = [
    'Komedo',
    'Jerawat',
    'Kulit',
    'Kutil',
    '10 +'
  ];
  final RxString selectedCategory = 'Komedo'.obs;

  final TextEditingController searchController = TextEditingController();
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  void fetchNews() async {
    try {
      isLoading(true);
      var articles = await newsProvider.fetchNewsArticles();
      newsArticles.assignAll(articles);
      filteredArticles.assignAll(articles);
    } catch (e) {
      errorMessage.value = 'Failed to load news';
      print('Error fetching news: $e');
    } finally {
      isLoading(false);
    }
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      filteredArticles.assignAll(newsArticles);
    } else {
      filteredArticles.assignAll(
        newsArticles
            .where((article) =>
                article.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    searchNews('');
  }
}
