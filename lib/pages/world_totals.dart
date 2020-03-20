import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/totals_widget.dart';
import 'package:provider/provider.dart';

class WorldTotals extends StatelessWidget {
  int _parseString(String data) {
    return int.parse(data.replaceAll(',', ''));
  }

  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3E0000),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'World Totals',
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 20.0,
                    fontFamily: pMedium,
                  ),
            ),
            Text(
              '${locData.date}',
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 12.0,
                    color: Colors.white,
                    fontFamily: pRegular,
                  ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkRed,
        ),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                TotalsWidget(
                  data: '${locData.moreResults.totalCases}',
                  dataColor: _parseString(locData.moreResults.totalCases) > 10
                      ? Colors.amberAccent
                      : Colors.greenAccent[100],
                  dataType: 'Total Cases',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                TotalsWidget(
                  data: '${locData.moreResults.totalDeaths}',
                  dataColor: _parseString(locData.moreResults.totalDeaths) > 10
                      ? Colors.amberAccent
                      : Colors.greenAccent[100],
                  dataType: 'Deaths',
                ),
                TotalsWidget(
                  data: '${locData.moreResults.totalRecovered}',
                  dataColor:
                      _parseString(locData.moreResults.totalRecovered) > 10
                          ? Colors.greenAccent
                          : Colors.amberAccent,
                  dataType: 'Recovered',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                TotalsWidget(
                  data: '${locData.moreResults.totalActiveCases}',
                  dataColor:
                      _parseString(locData.moreResults.totalActiveCases) > 10
                          ? Colors.amberAccent
                          : Colors.greenAccent,
                  dataType: 'Active Cases',
                )
              ],
            ),
            Row(
              children: <Widget>[
                TotalsWidget(
                  data: '${locData.moreResults.totalMild}',
                  dataColor: _parseString(locData.moreResults.totalMild) > 10
                      ? Colors.cyanAccent
                      : Colors.amberAccent,
                  dataType: 'Mild Condition',
                )
              ],
            ),
            Row(
              children: <Widget>[
                TotalsWidget(
                  data: '${locData.moreResults.totalSeriousCritical}',
                  dataColor: _parseString(locData.moreResults.totalMild) > 10
                      ? Colors.redAccent[400]
                      : Colors.amberAccent,
                  dataType: 'Serious / Critical',
                ),
                TotalsWidget(
                  data: '${locData.moreResults.totalDischarged}',
                  dataColor: _parseString(locData.moreResults.totalMild) > 10
                      ? Colors.greenAccent
                      : Colors.amberAccent,
                  dataType: 'Discharged',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}