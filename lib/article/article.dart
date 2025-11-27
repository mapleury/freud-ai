class ArticleModel {
  final String id;
  final String title;
  final String image;
  final String content;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      content: json['content'],
    );
  }
}
