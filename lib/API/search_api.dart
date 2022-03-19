import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Data/search_data.dart';
import 'package:news_app/Keys/api_key.dart';

class CategoryNews {
  List<CategoryInfo> catnews = [];

  Future<void> getcatnews(String categoryname) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=$categoryname&apiKey=$api_key';
    var response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      data['articles'].forEach(
        (element) {
          if (element['description'] != null && element['urlToImage'] != null) {
            CategoryInfo cats = CategoryInfo.fromJson(element);

            catnews.add(cats);
            return catnews;
          }
        },
      );
    }
  }
}
