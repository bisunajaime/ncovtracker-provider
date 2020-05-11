import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ncov_tracker/models/latestupdates_model.dart';

class LatestUpdatesData extends ChangeNotifier {
  String _searchTxt = "";
  bool _loading = true;
  List<LatestUpdatesModel> _latestUpdatesModel = [];
  DateTime _date = DateTime.now();
  TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  LatestUpdatesData() {
    fetchUpdates();
    notifyListeners();
  }

  setTextController(TextEditingController controller) {
    _controller = controller;
    notifyListeners();
  }

  clearTxt() {
    _controller.clear();
    notifyListeners();
  }

  String get searchTxt => _searchTxt.trim();

  search(String txt) {
    _controller.addListener(() {
      _searchTxt = _controller.text.trim();
    });
    notifyListeners();
  }

  String get date {
    return DateFormat.yMMMd().add_jm().format(_date);
  }

  void _setDate(DateTime theDate) {
    _date = theDate;
    notifyListeners();
  }

  bool get loading {
    return _loading;
  }

  void _setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  List<LatestUpdatesModel> get latestUpdatesModel {
    return _latestUpdatesModel;
  }

  fetchUpdates() async {
    _latestUpdatesModel.clear();
    _setLoading(true);
    _setDate(DateTime.now());

    _setDate(DateTime.now());
    http.Client client = http.Client();
    http.Response response = await client
        .get("https://first-express-app-276913.df.r.appspot.com/latest-news");
    List updatesList = jsonDecode(response.body) as List;
    _latestUpdatesModel =
        updatesList.map((l) => LatestUpdatesModel.fromJson(l)).toList();
    _setLoading(false);
  }
}
