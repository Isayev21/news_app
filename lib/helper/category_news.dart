import 'dart:convert';
import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;

class CategoryNewsClass {
  List<Article> news = [];

  Future<void> fetchCategoryNews(String category) async {
    var url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?category=$category&country=us&apiKey=398c7e121cd847b8b087c09b59629b04');
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var element in jsonData['articles']) {
        // Check for null values before creating Article instance
        if (element['urlToImage'] != null &&
            element['description'] != null &&
            element['title'] != null &&
            element['url'] != null &&
            element['content'] != null) {
          Article articleModel = Article(
            content: element['content'],
            description: element['description'],
            title: element['title'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          news.add(articleModel);
        }
      }
    }
  }
}
