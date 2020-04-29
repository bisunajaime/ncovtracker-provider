import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:ncov_tracker/models/location_model.dart';
import 'package:ncov_tracker/models/more_results.dart';

class LocationData extends ChangeNotifier {
  String _searchTxt = "";
  int _counter = 0;
  int _initialPage = 0;
  int _numberOfCols;
  bool _loading = true;
  bool _loadingTotals = true;
  dom.Document _document;
  MoreResults _moreResults;
  List<LocationModel> _locationList = [];

  DateTime _date = DateTime.now();

  TextEditingController _controller = TextEditingController();

  LocationData() {
    fetchData();
    fetchTotals();
    notifyListeners();
  }

  int get initialPage => _initialPage;

  setInitialPage(int index) {
    _initialPage = index;
    notifyListeners();
  }

  bool get loadingTotals => _loadingTotals;

  setLoadingTotals(bool isLoading) {
    _loadingTotals = isLoading;
    notifyListeners();
  }

  String get searchTxt {
    return _searchTxt;
  }

  TextEditingController get controller {
    return _controller;
  }

  int get numberOfCols => _numberOfCols;
  setNumberOfCols(int num) {
    _numberOfCols = num;
  }

  search(String str) {
    _controller.addListener(() {
      _searchTxt = _controller.text;
    });
    notifyListeners();
  }

  dom.Document get document {
    return _document;
  }

  MoreResults get moreResults {
    return _moreResults;
  }

  void clearTxt() {
    _controller.clear();
    Timer(Duration(seconds: 1), () {
      setLoading(true);
    });
    Timer(Duration(seconds: 1), () {
      setLoading(false);
    });

    notifyListeners();
  }

  int get counter {
    return _counter;
  }

  String get date {
    return DateFormat.yMMMd().add_jm().format(_date);
  }

  _setDate(DateTime theDate) {
    _date = theDate;
  }

  bool get loading => _loading;

  setLoading(bool l) {
    _loading = l;
    notifyListeners();
  }

  List<LocationModel> get locationList {
    return _locationList;
  }

  void fetchData() async {
    _locationList.clear();
    _setDate(DateTime.now());
    setLoading(true);
    http.Client client = http.Client();
    http.Response response =
        await client.get('https://covid19-codej.herokuapp.com/countries');
    List data = jsonDecode(response.body) as List;
    _locationList = data.map((d) => LocationModel.fromJson(d)).toList();
    client.close();
    setLoading(false);
  }

  void fetchTotals() async {
    setLoadingTotals(true);
    _setDate(DateTime.now());
    http.Client client = http.Client();
    http.Response resResponse =
        await client.get('https://covid19-codej.herokuapp.com/totals');
    _moreResults = MoreResults.fromJson(jsonDecode(resResponse.body));
    client.close();
    setLoadingTotals(false);
  }
}
