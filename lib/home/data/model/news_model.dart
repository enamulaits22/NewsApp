// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    NewsModel({
      required this.status,
      required this.totalResults,
      required this.articles,
    });

    final String? status;
    final int? totalResults;
    final List<Article>? articles;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"] ?? '',
        totalResults: json["totalResults"] ?? 0,
        articles: json["articles"] == null ? [] : List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status!,
        "totalResults": totalResults!,
        "articles": List<dynamic>.from(articles!.map((x) => x.toJson())),
    };
}

class Article {
    Article({
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
    });

    final String? author;
    final String? title;
    final String? description;
    final String? url;
    final String? urlToImage;
    final DateTime? publishedAt;
    final String? content;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        url: json["url"] ?? '',
        urlToImage: json["urlToImage"] ?? '',
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "author": author!,
        "title": title!,
        "description": description!,
        "url": url!,
        "urlToImage": urlToImage!,
        "publishedAt": publishedAt!.toIso8601String(),
        "content": content!,
    };
}
