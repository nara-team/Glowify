import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/news_article.dart';

class NewsProvider extends GetConnect {
  final String apiUrl = dotenv.env['NEWS_API_URL']!;
  final String apiKey = dotenv.env['NEWS_API_KEY']!;

  Future<List<NewsArticle>> fetchNewsArticles({String query = ''}) async {
    String url = '$apiUrl&apiKey=$apiKey';
    if (query.isNotEmpty) {
      url += '&q=$query';  // Menambahkan parameter query untuk pencarian
    }

    final response = await get(url);

    if (response.statusCode == 200) {
      List<dynamic> articles = response.body['articles']; 
      return articles.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
