import 'package:flutter/cupertino.dart';
import 'location_data.dart';
import 'package:html/dom.dart' as dom;

class MoreResultsData extends ChangeNotifier {
  LocationData _lD;
  List<dom.Element> _totalsCDR;
  List<dom.Element> _totalsARC;
  List<dom.Element> _totalsSD;

  List<dom.Element> get totalsCDR {
    return _totalsCDR;
  }

  _setTotalsCDR(List<dom.Element> totals) {
    _totalsCDR = totals;
  }

  void getMoreResults(dom.Document docu) {
    _setTotalsCDR(docu.querySelectorAll(
        'body div#maincounter-wrap .maincounter-number span'));
    print(totalsCDR);
  }
}
