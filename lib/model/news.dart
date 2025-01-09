class News {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String category;

  News({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.category,
  });

  factory News.fromJson(Map<String, dynamic> json, String category) {
    return News(
      title: json['title'] ?? 'No Title',
      subtitle: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ??
          'https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg',
      category: category,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'imageUrl': imageUrl,
        'category': category,
      };
}
