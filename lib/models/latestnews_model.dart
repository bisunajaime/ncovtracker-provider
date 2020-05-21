class LatestNewsModel {
  final String status;
  final int totalResults;
  final List<ArticlesList> articlesList;
  // articles

  LatestNewsModel({
    this.status,
    this.totalResults,
    this.articlesList,
  });

  factory LatestNewsModel.fromJson(Map<String, dynamic> json) {
    var articles = json['articles'] as List;
    List<ArticlesList> articlesData =
        articles.map((val) => ArticlesList.fromJson(val)).toList();

    return LatestNewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articlesList: articlesData,
    );
  }
}

class ArticlesList {
  final String sourceName,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content;
  ArticlesList({
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
  factory ArticlesList.fromJson(Map<String, dynamic> json) {
    return ArticlesList(
      sourceName: "https://${json['source']['name'].toString().toLowerCase()}",
      author: json['author'] ?? "No author",
      title: json['title'],
      description: json['description'] ?? "No description",
      url: json['url'] ?? "N/A",
      urlToImage: json['urlToImage'] ??
          "https://via.placeholder.com/500x500?text=no+image+available",
      publishedAt: json['publishedAt'],
      content: json['content'] ?? "Visit the website to learn more",
    );
  }
}
