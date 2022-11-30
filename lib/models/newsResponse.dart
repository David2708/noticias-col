
import 'dart:convert';

class NewsResponse {
    NewsResponse({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    String status;
    int totalResults;
    List<Article> articles;

    factory NewsResponse.fromJson(String str) => NewsResponse.fromMap(json.decode(str));

    factory NewsResponse.fromMap(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
    );
}

class Article {
    Article({
        required this.source,
        this.author,
        required this.title,
        this.description,
        required this.url,
        this.urlToImage,
        required this.publishedAt,
        this.content,
    });

    Source source;
    String? author;
    String title;
    String? description;
    String url;
    String? urlToImage;
    DateTime publishedAt;
    String? content;

    factory Article.fromJson(String str) => Article.fromMap(json.decode(str));

    factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: Source.fromMap(json["source"]),
        author: json["author"] == null ? null : json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

}

class Source {
    Source({
        this.id,
        required this.name,
    });

    String? id;
    String name;

    factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"] == null ? null : json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name,
    };
}
