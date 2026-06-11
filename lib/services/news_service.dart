import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  static const String _url = 'https://api.rss2json.com/v1/api.json?rss_url=https://cointelegraph.com/rss';

  Future<List<NewsArticle>> getNews() async {
    try {
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'ok') {
          final List<dynamic> data = jsonResponse['items'];
          return data.map((item) => NewsArticle.fromJson(item)).toList();
        } else {
          throw Exception('Failed to load news due to invalid status');
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}