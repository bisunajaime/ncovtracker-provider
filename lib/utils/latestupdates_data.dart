import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ncov_tracker/models/latestupdates_model.dart';

class LatestUpdatesData extends ChangeNotifier {
  final String _url = "https://www.worldometers.info/coronavirus/";
  String _searchTxt = "";
  bool _loading = true;
  List<LatestUpdatesModel> _latestUpdatesModel = [];
  DateTime _date = DateTime.now();
  TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  LatestUpdatesData() {
    loadLatestUpdates();
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

  String get searchTxt => _searchTxt;

  search(String txt) {
    _controller.addListener(() {
      _searchTxt = _controller.text;
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
    print(loading);
    notifyListeners();
  }

  List<LatestUpdatesModel> get latestUpdatesModel {
    return _latestUpdatesModel;
  }

  String _filterText(String text) {
    String newText = text
        .replaceAll('<strong>', '')
        .replaceAll('</strong>', '')
        .replaceAll('&nbsp;', '')
        .replaceAll('<sup>', '')
        .replaceAll('[source]', '')
        .trim();
    return newText;
  }

  loadLatestUpdates() async {
    _clearLists();
    _setLoading(true);
    _setDate(DateTime.now());
    http.Client client = http.Client();
    http.Response response = await client.get(_url);
    var document = parse(response.body);
    Map<String, dynamic> listUpdateData = {};
    List<String> storedStrong = [];

    document.querySelectorAll("[id*='newsdate']").forEach((newsDate) {
      newsDate.children.forEach((news) {
        if (news.querySelectorAll('.news_post').length != 1) {
          if (!news.id.contains('newsdate')) {
            storedStrong
                .add(_filterText(parse(news.innerHtml).documentElement.text));
          }
        } else {
          print('nope');
        }
      });
      List<String> removeDups = storedStrong.toSet().toList();
      listUpdateData['${newsDate.id}'] = {
        'date': '${newsDate.id}',
        'news_post': removeDups,
      };
      _latestUpdatesModel
          .add(LatestUpdatesModel.fromJson(listUpdateData['${newsDate.id}']));
      listUpdateData.clear();
      storedStrong.clear();
      // print(true);
    });
    _latestUpdatesModel.removeLast();
    _latestUpdatesModel.removeLast();
    _setLoading(false);
    print(loading);
  }

  void _clearLists() {
    _latestUpdatesModel.clear();
    print('Clearing list');
    notifyListeners();
  }
}
