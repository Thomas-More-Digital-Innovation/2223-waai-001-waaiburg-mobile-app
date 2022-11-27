// Placeholder, should be generated from the api.

class NewsArticle {
  NewsArticle({
    this.title,
    this.shortDescription,
    this.content,
    this.contentIsLoaded,
    this.id,
    this.publishTime,
  });

  String title; // The actual title of the aricle
  String shortDescription; // A short description of the article to show in the list of articles
  String content; // The content of this article aka the full text
  bool contentIsLoaded = false; // Is the actual content of this article loaded?
  int id; // Maybe needed for caching?
  DateTime publishTime; // The time this article was published
  String url; // The url to querry to get the full data

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
        title: json["titel"] == null ? null : json["titel"],
        shortDescription: json["korteInhoud"] == null ? null : json["korteInhoud"],
        content: json["inhoud"] == null ? null : json["inhoud"],
        id: json["nieuwtjesId"] == null ? null : json["nieuwtjesId"],
        publishTime: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        contentIsLoaded: true,
      );
}
