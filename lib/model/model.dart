class NewsModel {
  late String newsHead;
  late String newsDes;
  late String newsImg;
  late String newsUrl;
  late String content;
  late String author;
  late String sourceName;

  NewsModel(
      {this.newsHead = "NEWS HEADLINE",
      this.newsDes = "SOME NEWS",
      this.newsImg = "SOME URL",
      this.newsUrl = "SOME URL",
      this.content = "",
      this.author = "UNKNOWN",
      this.sourceName = "UNKNOWN SOURCE"});

  factory NewsModel.fromMap(Map<String, dynamic> news) {
    return NewsModel(
        newsHead: news["title"] ?? "NEWS HEADLINE",
        newsDes: news["description"] ?? "SOME NEWS",
        newsImg: news["image"] ?? "SOME URL",
        newsUrl: news["url"] ?? "SOME URL",
        content: news["content"] ?? "",
        author: news["author"] ?? "UNKNOWN",
        sourceName: news["source"]["name"] ?? "UNKNOWN SOURCE");
  }

  Map<String, dynamic> toMap() {
    return {
      'title': newsHead,
      'description': newsDes,
      'urlToImage': newsImg,
      'url': newsUrl,
      'content': content,
      'author': author,
      'source': {'name': sourceName},
    };
  }
}
