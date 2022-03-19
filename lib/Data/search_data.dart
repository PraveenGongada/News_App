class CategoryInfo {
  String title;
  String description;
  String urlToImage;
  String url;

  CategoryInfo(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.url});

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      url: json['url'],
    );
  }
}
