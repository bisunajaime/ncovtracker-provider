import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncov_tracker/models/location_model.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/data_container.dart';
import 'package:ncov_tracker/widgets/test_widget.dart';
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
    LocationModel locMod = widget.locationModel;
    TextTheme textStyle = Theme.of(context).textTheme;
    final locProv = Provider.of<LocationData>(context);

    return Scaffold(
      backgroundColor: smokyBlack,
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
                fontSize: 10.0,
                color: Colors.redAccent[100],
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
                    CircularProgressIndicator(),
                    Text('Loading'),
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
                                  fontFamily: pMedium,
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
                                      ? Colors.amberAccent[100]
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
                                      ? Colors.redAccent[100]
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Text(
                      'Cases overtime',
                      style: textStyle.title.copyWith(
                        fontSize: 15.0,
                        fontFamily: pMedium,
                      ),
                    ),
                  ),
                  Container(
                    child: SfCartesianChart(
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
                          borderColor: Colors.orange,
                        ),
                      ),
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                          text: 'Dates',
                        ),
                      ),
                      series: <LineSeries<DateData, String>>[
                        LineSeries<DateData, String>(
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
                          color: Colors.orange,
                          xValueMapper: (DateData date, _) => date.date,
                          yValueMapper: (DateData data, _) => data.data,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Text(
                      'Deaths overtime',
                      style: textStyle.title.copyWith(
                        fontSize: 15.0,
                        fontFamily: pMedium,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SfCartesianChart(
                      tooltipBehavior: TooltipBehavior(
                        activationMode: ActivationMode.doubleTap,
                        enable: true,
                        header: 'Deaths',
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
                          borderColor: Colors.redAccent[100],
                        ),
                      ),
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                          text: 'Dates',
                        ),
                      ),
                      series: <LineSeries<DateData, String>>[
                        LineSeries<DateData, String>(
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
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Text(
                      'Recovery overtime',
                      style: textStyle.title.copyWith(
                        fontSize: 15.0,
                        fontFamily: pMedium,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: SfCartesianChart(
                      tooltipBehavior: TooltipBehavior(
                        activationMode: ActivationMode.doubleTap,
                        enable: true,
                        header: 'Recovered',
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
                          borderColor: Colors.greenAccent[100],
                        ),
                      ),
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                          text: 'Dates',
                        ),
                        arrangeByIndex: true,
                      ),
                      series: <LineSeries<DateData, String>>[
                        LineSeries<DateData, String>(
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
                        )
                      ],
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
