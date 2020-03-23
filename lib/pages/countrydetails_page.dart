import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncov_tracker/models/location_model.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:http/http.dart' as http;
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/data_container.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CountryDetails extends StatefulWidget {
  final LocationModel locationModel;

  CountryDetails({this.locationModel});

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  bool loading = true;
  LocationHistory locationHistory;

  // TODO: Future function getting the data from API
  Future<void> fetchData(String country) async {
    if (country == "USA") {
      country = "US";
    } else if (country == "S. Korea") {
      country = "Korea, South";
    }
    print(country);
    http.Client client = http.Client();
    http.Response response =
        await client.get("https://corona.lmao.ninja/historical/$country");
    var data = response.body;
    var jsonData = jsonDecode(data);

    setState(() {
      locationHistory = LocationHistory.fromJson(jsonData);
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData(widget.locationModel.country);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    LocationModel locMod = widget.locationModel;
    TextTheme textStyle = Theme.of(context).textTheme;
    final locProv = Provider.of<LocationData>(context);

    return Scaffold(
      backgroundColor: richBlack,
      appBar: AppBar(
        backgroundColor: eerieBlack,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Country Details',
              style: textStyle.title.copyWith(
                fontSize: 20.0,
              ),
            ),
            Text(
              '${locProv.date}',
              style: textStyle.body1.copyWith(
                fontFamily: pMedium,
                fontSize: 12.0,
                color: deepPuce,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: loading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: russianViolet,
                      valueColor: AlwaysStoppedAnimation<Color>(deepPuce),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Loading',
                      style: TextStyle(
                        color: dustStorm,
                      ),
                    ),
                  ],
                ),
              )
            : ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: int.parse(widget.locationModel.totalCases
                                          .replaceAll(',', '')) >
                                      10
                                  ? Colors.redAccent[100]
                                  : Colors.greenAccent[100],
                              size: 20.0,
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                '${locMod.country}',
                                overflow: TextOverflow.ellipsis,
                                style: textStyle.title.copyWith(
                                  fontFamily: pBold,
                                  color: antiFlashWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${widget.locationModel.newCases}',
                              style: TextStyle(
                                fontSize: 16,
                                color: widget.locationModel.newCases == 'NO'
                                    ? Colors.greenAccent
                                    : Colors.yellowAccent,
                                fontFamily: pBold,
                              ),
                            ),
                            Text(
                              'New Cases',
                              style: TextStyle(
                                fontSize: 10,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            DataContainer(
                              data: widget.locationModel.totalCases,
                              type: 'Total Cases',
                              dataColor: int.parse(widget
                                          .locationModel.totalCases
                                          .replaceAll(',', '')) >
                                      10
                                  ? Colors.amberAccent[100]
                                  : Colors.greenAccent[100],
                            ),
                            DataContainer(
                              data: widget.locationModel.totalDeaths,
                              type: 'Total Deaths',
                              dataColor: widget.locationModel.totalDeaths ==
                                      'NONE'
                                  ? Colors.greenAccent[100]
                                  : int.parse(widget.locationModel.totalDeaths
                                              .replaceAll(',', '')) >
                                          10
                                      ? Colors.purpleAccent[100]
                                      : Colors.greenAccent[100],
                            ),
                            DataContainer(
                              data: widget.locationModel.newDeaths,
                              type: 'New Deaths',
                              dataColor: widget.locationModel.activeCases ==
                                      'NONE'
                                  ? Colors.greenAccent[100]
                                  : int.parse(widget.locationModel.activeCases
                                              .replaceAll(',', '')) >
                                          10
                                      ? Colors.purpleAccent[100]
                                      : Colors.greenAccent[100],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            DataContainer(
                              data: widget.locationModel.totalRecovered,
                              type: 'Total Recovered',
                              dataColor: widget.locationModel.newDeaths == 'NO'
                                  ? Colors.greenAccent[100]
                                  : int.parse(widget.locationModel.totalDeaths
                                              .replaceAll(',', '')
                                              .replaceAll('+', '')) <
                                          10
                                      ? Colors.purpleAccent[100]
                                      : Colors.greenAccent[100],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            DataContainer(
                              data: widget.locationModel.seriousCritical,
                              type: 'Serious, Critical',
                              dataColor:
                                  widget.locationModel.seriousCritical == 'NONE'
                                      ? Colors.greenAccent[100]
                                      : int.parse(widget
                                                  .locationModel.seriousCritical
                                                  .replaceAll(',', '')) >
                                              10
                                          ? Colors.redAccent[100]
                                          : Colors.greenAccent[100],
                            ),
                            DataContainer(
                              data: widget.locationModel.activeCases,
                              type: 'Active Cases',
                              dataColor: widget.locationModel.activeCases ==
                                      'NONE'
                                  ? Colors.greenAccent[100]
                                  : int.parse(widget.locationModel.activeCases
                                              .replaceAll(',', '')) >
                                          10
                                      ? Colors.redAccent[100]
                                      : Colors.greenAccent[100],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: SfCartesianChart(
                      backgroundColor: eerieBlack,
                      tooltipBehavior: TooltipBehavior(
                        activationMode: ActivationMode.doubleTap,
                        enable: true,
                        header: 'Cases',
                      ),
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        activationMode: ActivationMode.singleTap,
                        lineWidth: 2.0,
                        lineColor: Colors.white,
                        tooltipSettings: InteractiveTooltip(
                          textStyle: ChartTextStyle(
                            color: Colors.black,
                            fontFamily: pBold,
                          ),
                          format: 'point.x : point.y',
                          borderColor: Colors.orange,
                        ),
                      ),
                      title: ChartTitle(
                        text: 'Timeline',
                        textStyle: ChartTextStyle(
                          color: antiFlashWhite,
                          fontFamily: pBold,
                        ),
                      ),
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                          text: 'Dates',
                          textStyle: ChartTextStyle(
                            fontFamily: pBold,
                            color: antiFlashWhite,
                          ),
                        ),
                      ),
                      legend: Legend(
                        title: LegendTitle(
                          text: 'Legend',
                          textStyle: ChartTextStyle(
                            color: Colors.white,
                            fontFamily: pBold,
                          ),
                        ),
                        isVisible: true,
                        isResponsive: true,
                        position: LegendPosition.bottom,
                        backgroundColor: Color(0xff6d607a),
                        textStyle: ChartTextStyle(
                          fontFamily: pRegular,
                        ),
                      ),
                      series: <LineSeries<DateData, String>>[
                        LineSeries<DateData, String>(
                          legendItemText: 'Cases',
                          dataSource: List.generate(
                            locationHistory.casesHistory.keys.toList().length,
                            (i) {
                              return DateData(
                                date: locationHistory.casesHistory.keys
                                    .toList()[i],
                                data: locationHistory.casesHistory.values
                                    .toList()[i],
                              );
                            },
                          ),
                          color: Colors.orangeAccent,
                          xValueMapper: (DateData date, _) => date.date,
                          yValueMapper: (DateData data, _) => data.data,
                        ),
                        LineSeries<DateData, String>(
                          legendItemText: 'Recovered',
                          dataSource: List.generate(
                            locationHistory.recoveredHistory.keys
                                .toList()
                                .length,
                            (i) {
                              return DateData(
                                date: locationHistory.recoveredHistory.keys
                                    .toList()[i],
                                data: locationHistory.recoveredHistory.values
                                    .toList()[i],
                              );
                            },
                          ),
                          color: Colors.greenAccent[100],
                          xValueMapper: (DateData date, _) => date.date,
                          yValueMapper: (DateData data, _) => data.data,
                        ),
                        LineSeries<DateData, String>(
                          legendItemText: 'Deaths',
                          dataSource: List.generate(
                            locationHistory.deathsHistory.keys.toList().length,
                            (i) {
                              return DateData(
                                date: locationHistory.deathsHistory.keys
                                    .toList()[i],
                                data: locationHistory.deathsHistory.values
                                    .toList()[i],
                              );
                            },
                          ),
                          color: Colors.redAccent[100],
                          xValueMapper: (DateData date, _) => date.date,
                          yValueMapper: (DateData data, _) => data.data,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? Text(
                            '',
                            style: textStyle.title.copyWith(
                              fontFamily: pMedium,
                              fontSize: 15.0,
                            ),
                          )
                        : Text(
                            'Rotate Device for Landscape',
                            style: textStyle.title.copyWith(
                              fontFamily: pRegular,
                              fontSize: 15.0,
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}

class DateData {
  final String date;
  final int data;

  DateData({this.date, this.data});
}

class LocationHistory {
  final Map<String, dynamic> casesHistory;
  final Map<String, dynamic> deathsHistory;
  final Map<String, dynamic> recoveredHistory;

  LocationHistory(
      {this.casesHistory, this.deathsHistory, this.recoveredHistory});

  factory LocationHistory.fromJson(Map<String, dynamic> json) {
    return LocationHistory(
      casesHistory: json['timeline']['cases'],
      deathsHistory: json['timeline']['deaths'],
      recoveredHistory: json['timeline']['recovered'],
    );
  }
}
