import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/news_article.dart';

class NewsProvider extends GetConnect {
  final String apiUrl = dotenv.env['NEWS_API_URL']!;

  Future<List<NewsArticle>> fetchNewsArticles() async {
    final response = await get(apiUrl);

    if (response.statusCode == 200) {
      List<dynamic> posts = response.body['data']['posts'];

      return posts.map((article) => NewsArticle.fromJson(article)).toList();
    } else {
      throw Exception('Gagal memuat berita');
    }
  }
}
