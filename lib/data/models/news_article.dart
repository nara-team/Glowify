class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['link'] as String,
      urlToImage: json['thumbnail'] as String?,
      publishedAt: DateTime.parse(json['pubDate'] as String),
    );
  }
}

class NewsResponse {
  final String link;
  final String image;
  final String description;
  final String title;
  final List<NewsArticle> posts;

  NewsResponse({
    required this.link,
    required this.image,
    required this.description,
    required this.title,
    required this.posts,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data']['posts'] as List;
    List<NewsArticle> postsList =
        list.map((i) => NewsArticle.fromJson(i)).toList();

    return NewsResponse(
      link: json['data']['link'] as String,
      image: json['data']['image'] as String,
      description: json['data']['description'] as String,
      title: json['data']['title'] as String,
      posts: postsList,
    );
  }
}
