import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_app/Data/home_data.dart';
import 'package:news_app/Keys/api_key.dart';

class HeadLines {
  List<HomeInfo> newss = [];
  Future<List<HomeInfo>> getnews(String country) async {
    var jsondata = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$api_key'),
    );
    var data = jsonDecode(jsondata.body);

    if (data["status"] == 'ok') {
      data['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          HomeInfo info = HomeInfo(
            title: element['title'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            url: element['url'],
          );

          newss.add(info);
        }
      });
    }

    return newss;
  }
}
