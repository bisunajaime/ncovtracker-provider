import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ncov_tracker/models/latestnews_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LatestNewsData extends ChangeNotifier {
  final String key = "bc7ba9b23d024c48a0aa1d1c91437446";
  String baseURL =
      "https://newsapi.org/v2/top-headlines?category=health&country=ph&apiKey=";
  String _category = "science";
  LatestNewsModel latestNews;

  String get category => _category;

  setCategory(String type) {
    _category = type;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  // fetch data
  Future<LatestNewsModel> getLatestNews() async {
    if (category != "covid") {
      http.Client client = new http.Client();
      http.Response response = await client.get(
          'https://newsapi.org/v2/top-headlines?category=$category&country=ph&apiKey=$key');
      var data = jsonDecode(response.body);
      latestNews = LatestNewsModel.fromJson(data);
      print(latestNews.articlesList.length);
      return latestNews;
    } else {
      http.Client client = new http.Client();
      http.Response response = await client.get(
          'https://newsapi.org/v2/everything?q=covid&qInTitle=covid&language=en&pageSize=50&apiKey=$key');
      var data = jsonDecode(response.body);
      latestNews = LatestNewsModel.fromJson(data);
      print(latestNews.articlesList.length);
      return latestNews;
    }
  }
}
