// lib/data/provider/news_provider.dart

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/news_article.dart';

class NewsProvider extends GetConnect {
  final String _baseUrl = dotenv.env['NEWS_API_URL']!;
  final String _apiKey = dotenv.env['NEWS_API_KEY']!;

  Future<List<NewsArticle>> fetchNewsArticles() async {
    final response = await get('$_baseUrl&apiKey=$_apiKey');

    if (response.statusCode == 200) {
      List<dynamic> articlesJson = response.body['articles'];
      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
