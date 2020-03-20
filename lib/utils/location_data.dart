import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:ncov_tracker/models/location_model.dart';
import 'package:ncov_tracker/models/more_results.dart';

class LocationData extends ChangeNotifier {
  String _searchTxt = "";
  int _counter = 0;
  bool _loading = true;
  dom.Document _document;
  MoreResults _moreResults;

  List<String> _countriesList = [];
  List<String> _totalCasesList = [];
  List<String> _newCasesList = [];
  List<String> _totalDeathsList = [];
  List<String> _newDeathsList = [];
  List<String> _totalRecoveredList = [];
  List<String> _activeCasesList = [];
  List<String> _seriousCriticalList = [];
  List<dom.Element> _totalCases = [];
  List<LocationModel> _locationList = [];

  DateTime _date = DateTime.now();

  TextEditingController _controller = TextEditingController();

  String get searchTxt {
    return _searchTxt;
  }

  TextEditingController get controller {
    return _controller;
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

  _setMoreResults(MoreResults moreResults) {
    _moreResults = moreResults;
  }

  _setDocument(dom.Document doc) {
    _document = doc;
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

  List<String> get countriesList {
    return _countriesList;
  }

  List<String> get totalCasesList {
    return _totalCasesList;
  }

  List<String> get newCasesList {
    return _newCasesList;
  }

  List<String> get totalDeathsList {
    return _totalDeathsList;
  }

  List<String> get newDeathsList {
    return _newDeathsList;
  }

  List<String> get totalRecoveredList {
    return _totalRecoveredList;
  }

  List<String> get activeCasesList {
    return _activeCasesList;
  }

  List<String> get seriousCriticalList {
    return _seriousCriticalList;
  }

  List<dom.Element> totalCases() {
    return _totalCases;
  }

  List<LocationModel> get locationList {
    return _locationList;
  }

  void _addTotalCases(int i) {
    if (i % 9 == 0) {
      if (_totalCases[i].innerHtml.contains('<a')) {
        _countriesList.add(_totalCases[i].querySelector('a').innerHtml.trim());
      } else if (_totalCases[i].innerHtml.contains('<span')) {
        _countriesList
            .add(_totalCases[i].querySelector('span').innerHtml.trim());
      } else {
        _countriesList.add(_totalCases[i].innerHtml.trim());
      }
    }
  }

  void _addTotalCasesList(int i) {
    if (i % 9 == 1) {
      _totalCasesList.add(_totalCases[i].innerHtml.trim());
    }
  }

  void _addNewCasesList(int i) {
    if (i % 9 == 2) {
      if (_totalCases[i].innerHtml.trim().length != 0) {
        _newCasesList.add(_totalCases[i].innerHtml.trim());
      } else {
        _newCasesList.add('NO');
      }
    }
  }

  void _addTotalDeathsList(int i) {
    if (i % 9 == 3) {
      if (_totalCases[i].innerHtml.trim().length != 0) {
        _totalDeathsList.add(_totalCases[i].innerHtml.trim());
      } else {
        _totalDeathsList.add('NONE');
      }
    }
  }

  void _addNewDeathsList(int i) {
    if (i % 9 == 4) {
      if (_totalCases[i].innerHtml.trim().length != 0) {
        _newDeathsList.add(_totalCases[i].innerHtml.trim());
      } else {
        _newDeathsList.add('NO');
      }
    }
  }

  void _addTotalRecoveredList(int i) {
    if (i % 9 == 5) {
      if (_totalCases[i].innerHtml.trim().length != 0) {
        _totalRecoveredList.add(_totalCases[i].innerHtml.trim());
      } else {
        _totalRecoveredList.add('NONE');
      }
    }
  }

  void _addActiveCasesList(int i) {
    if (i % 9 == 6) {
      if (_totalCases[i].innerHtml.trim().length != 0) {
        _activeCasesList.add(_totalCases[i].innerHtml.trim());
      } else {
        _activeCasesList.add('NONE');
      }
    }
  }

  void _addSerioudCriticalList(int i) {
    if (i % 9 == 7) {
      if (_totalCases[i].innerHtml.trim().length != 0) {
        _seriousCriticalList.add(_totalCases[i].innerHtml.trim());
      } else {
        _seriousCriticalList.add('NONE');
      }
    }
  }

  void _removeLastItem() {
    _countriesList.removeLast();
    _totalCasesList.removeLast();
    _newCasesList.removeLast();
    _totalDeathsList.removeLast();
    _newDeathsList.removeLast();
    _totalRecoveredList.removeLast();
    _activeCasesList.removeLast();
    _seriousCriticalList.removeLast();
    _locationList.removeLast();
    notifyListeners();
  }

  void _clearLists() {
    _countriesList.clear();
    _totalCasesList.clear();
    _newCasesList.clear();
    _totalDeathsList.clear();
    _newDeathsList.clear();
    _totalRecoveredList.clear();
    _activeCasesList.clear();
    _seriousCriticalList.clear();
    _locationList.clear();
    _controller.clear();
    notifyListeners();
  }

  void _addToDataList() {
    for (int i = 0; i < _countriesList.length; i++) {
      Map<String, dynamic> json = {
        'country': _countriesList[i],
        'totalCases': _totalCasesList[i],
        'newCases': _newCasesList[i],
        'totalDeaths': _totalDeathsList[i],
        'newDeaths': _newDeathsList[i],
        'totalRecovered': _totalRecoveredList[i],
        'activeCases': _activeCasesList[i],
        'seriousCritical': _seriousCriticalList[i],
      };
      locationList.add(LocationModel.fromJson(json));
    }
  }

  void loadData() async {
    // clear list
    _clearLists();
    _setDate(DateTime.now());
    setLoading(true);
    print(_countriesList.length);
    // make http request
    http.Client client = http.Client();
    http.Response response =
        await client.get('https://www.worldometers.info/coronavirus/');
    // parse response body
    var document = parse(response.body);
    _setDocument(document);
    _getTotals();
    // select table data
    _totalCases = document
        .querySelectorAll('#main_table_countries_today > tbody > tr > td');
    // loop and extract data
    for (var i = 0; i < _totalCases.length; i++) {
      _addTotalCases(i);
      _addTotalCasesList(i);
      _addNewCasesList(i);
      _addTotalDeathsList(i);
      _addNewDeathsList(i);
      _addTotalRecoveredList(i);
      _addActiveCasesList(i);
      _addSerioudCriticalList(i);
    }
    _addToDataList();
    print(locationList.length);
    setLoading(false);
    _removeLastItem();
  }

  void _getTotals() {
    List<dom.Element> totalsCDR = document
        .querySelectorAll('body div#maincounter-wrap .maincounter-number span');
    print('printing');
    List<dom.Element> totalsARC =
        document.querySelectorAll('body div.panel_front div.number-table-main');
    List<dom.Element> totalsSD =
        document.querySelectorAll('body div.panel_front span.number-table');
    _setMoreResults(MoreResults(
      totalCases: totalsCDR[0].innerHtml.trim() ?? 'NONE',
      totalDeaths: totalsCDR[1].innerHtml.trim() ?? 'NONE',
      totalRecovered: totalsCDR[2].innerHtml.trim() ?? 'NONE',
      totalActiveCases: totalsARC[0].innerHtml.trim() ?? 'NONE',
      totalClosedCases: totalsARC[1].innerHtml.trim() ?? 'NONE',
      totalMild: totalsSD[0].innerHtml.trim() ?? 'NONE',
      totalSeriousCritical: totalsSD[1].innerHtml.trim() ?? 'NONE',
      totalDischarged: totalsSD[2].innerHtml.trim() ?? 'NONE',
    ));
  }
}
