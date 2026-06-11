class NewsArticle {
  final String title;
  final String body;
  final String imageUrl;
  final String source;
  final String url;

  NewsArticle({
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.source,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    String imgUrl = json['thumbnail'] as String? ?? '';
    if (imgUrl.isEmpty && json['enclosure'] != null && json['enclosure'] is Map) {
      imgUrl = json['enclosure']['link'] as String? ?? '';
    }

    String description = json['description'] as String? ?? '';
    description = description.replaceAll(RegExp(r'<[^>]*>'), '').trim();

    return NewsArticle(
      title: json['title'] as String? ?? 'No Title',
      body: description,
      imageUrl: imgUrl,
      source: 'Cointelegraph',
      url: json['link'] as String? ?? '',
    );
  }
}