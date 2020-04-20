import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/totals_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class WorldTotals extends StatelessWidget {
  int _parseString(String data) {
    return int.parse(data.replaceAll(',', ''));
  }

  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationData>(context);

    return Scaffold(
      backgroundColor: eerieBlack,
      appBar: AppBar(
        backgroundColor: russianViolet,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'World Totals',
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 20.0,
                    fontFamily: pBold,
                  ),
            ),
            Text(
              '${locData.date}',
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    fontSize: 10.0,
                    color: dustStorm,
                    fontFamily: pMedium,
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
          color: richBlack,
        ),
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                      ? Colors.purpleAccent[100]
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
                      ? Colors.redAccent[100]
                      : Colors.amberAccent,
                  dataType: 'Serious / Critical',
                ),
                TotalsWidget(
                  data: '${locData.moreResults.totalClosedCases}',
                  dataColor: _parseString(locData.moreResults.totalClosedCases) > 10
                      ? Colors.greenAccent
                      : Colors.amberAccent,
                  dataType: 'Closed',
                ),
              ],
            ),
            RatioWidget(),
          ],
        ),
      ),
    );
  }
}

class RatioWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LocationData>(context);

    double deathRatio =
        double.parse(model.moreResults.totalDeaths.replaceAll(',', '')) /
            double.parse(model.moreResults.totalCases.replaceAll(',', ''));
    double recoverRatio =
        double.parse(model.moreResults.totalRecovered.replaceAll(',', '')) /
            double.parse(model.moreResults.totalCases.replaceAll(',', ''));
    double activeRatio =
        double.parse(model.moreResults.totalActiveCases.replaceAll(',', '')) /
            double.parse(model.moreResults.totalCases.replaceAll(',', ''));
    double mildRatio =
        double.parse(model.moreResults.totalMild.replaceAll(',', '')) /
            double.parse(model.moreResults.totalCases.replaceAll(',', ''));

    return Container(
      height: 200,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              CircularPercentIndicator(
                header: Text('Deaths'),
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: deathRatio,
                center: new Text(
                  "${(deathRatio * 100).round()}%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: eerieBlack,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent,
                    Colors.redAccent,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              CircularPercentIndicator(
                header: Text('Recovery'),
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: recoverRatio,
                center: new Text(
                  "${(recoverRatio * 100).round()}%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: eerieBlack,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.greenAccent,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              CircularPercentIndicator(
                header: Text('Active'),
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: activeRatio,
                center: new Text(
                  "${(activeRatio * 100).round()}%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: eerieBlack,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.amberAccent,
                    Colors.orangeAccent,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              CircularPercentIndicator(
                header: Text('Mild'),
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: mildRatio,
                center: new Text(
                  "${(mildRatio * 100).round()}%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: eerieBlack,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.purpleAccent,
                    Colors.indigoAccent,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
