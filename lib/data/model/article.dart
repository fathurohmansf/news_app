import 'dart:convert';

ArticlesResult articlesResultFromJson(String str) =>
    ArticlesResult.fromJson(json.decode(str));

String articlesResultToJson(ArticlesResult data) => json.encode(data.toJson());

class ArticlesResult {
  final String status;
  final int totalResults;
  final List<Article> articles;

  ArticlesResult({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticlesResult.fromJson(Map<String, dynamic> json) => ArticlesResult(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from((json["articles"] as List)
            .map((x) => Article.fromJson(x))
            .where((article) =>
                article.author != null &&
                article.urlToImage != null &&
                article.publishedAt != null &&
                article.content != null)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  Article({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
