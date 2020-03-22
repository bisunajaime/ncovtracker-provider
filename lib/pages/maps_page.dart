import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/models/location_data_model.dart';
import 'package:ncov_tracker/models/location_model.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:ncov_tracker/widgets/data_container.dart';

class MapsPage extends StatefulWidget {
  final List<LocationModel> locationData;

  MapsPage({this.locationData});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  LatLng initialPos = LatLng(12, 121);
  bool didTap = false;
  MapController mapController = MapController();
  LocationModel initialLocation;

  List<Marker> markerList = [];
  List<LocationDataModel> locData = [];
  bool _loading = true;

  Future<void> loadLocations() async {
    setState(() {
      _loading = true;
    });
    http.Client client = http.Client();
    http.Response response = await client
        .get('https://coronavirus-tracker-api.herokuapp.com/confirmed');
    var body = jsonDecode(response.body);

    var urlLocArr = body['locations'];

    for (int i = 0; i < urlLocArr.length; i++) {
      Map<String, dynamic> data = {
        'country': urlLocArr[i]['country'],
        'lat': urlLocArr[i]['coordinates']['lat'],
        'long': urlLocArr[i]['coordinates']['long'],
      };
      locData.add(LocationDataModel.fromJson(data));
    }
    client.close();
    Future<MapController> mc = mapController.onReady;
    mc.whenComplete(() {
      print('complete');
    }).catchError((onError) {
      print(onError);
      setState(() {
        _loading = false;
      });
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: fetch data
    loadLocations();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    setState(() {
      locData.clear();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: smokyBlack,
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
        backgroundColor: eerieBlack,
      ),
      body: Container(
        color: Color(0xff343332),
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: FlutterMap(
                      key: Key('maps'),
                      mapController: mapController,
                      options: new MapOptions(
                          center: initialPos,
                          zoom: 1.5,
                          minZoom: 1.5,
                          interactive: true,
                          debug: true,
                          onPositionChanged: (pos, b) {
                            setState(() {
                              initialPos = pos.center;
                            });
                          }),
                      layers: [
                        TileLayerOptions(
                          backgroundColor: Color(0xff191a1a),
                          urlTemplate:
                              'https://tile.jawg.io/dark/{z}/{x}/{y}.png?api-key=community',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(
                          markers: List.generate(
                            widget.locationData.length,
                            (i) {
                              for (int x = 0; x < locData.length; x++) {
                                if (locData[x].country ==
                                    widget.locationData[i].country) {
                                  var data = locData[x];
                                  return Marker(
                                    point: LatLng(
                                      double.parse(data.lat),
                                      double.parse(data.long),
                                    ),
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            didTap = true;
                                            initialLocation =
                                                widget.locationData[i];
                                            initialPos = LatLng(
                                              double.parse(data.lat),
                                              double.parse(data.long),
                                            );
                                            mapController.move(
                                                LatLng(
                                                  double.parse(data.lat),
                                                  double.parse(data.long),
                                                ),
                                                4.0);
                                          });
                                        },
                                        child: Icon(
                                          Icons.location_on,
                                          color: int.parse(widget
                                                      .locationData[i]
                                                      .totalCases
                                                      .replaceAll(',', '')) >=
                                                  10
                                              ? Colors.redAccent[100]
                                              : Colors.greenAccent[100],
                                          size: 40.0,
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                              return Marker();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: !didTap
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.redAccent[100],
                                  size: 30.0,
                                ),
                                Text(
                                  'Select a Marker',
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .copyWith(
                                        fontSize: 25.0,
                                        fontFamily: pBold,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            color: smokyBlack,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('${initialLocation.country}'),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  children: <Widget>[
                                    DataContainer(
                                      data: initialLocation.totalCases,
                                      type: 'Total Cases',
                                      dataColor: int.parse(initialLocation
                                                  .totalCases
                                                  .replaceAll(',', '')) >
                                              10
                                          ? Colors.amberAccent[100]
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
                                      data: initialLocation.totalRecovered,
                                      type: 'Total Recovered',
                                      dataColor: int.parse(initialLocation
                                                  .totalRecovered
                                                  .replaceAll(',', '')) >
                                              10
                                          ? Colors.greenAccent[100]
                                          : Colors.redAccent[100],
                                    ),
                                    DataContainer(
                                      data: initialLocation.totalDeaths,
                                      type: 'Total Deaths',
                                      dataColor: int.parse(initialLocation
                                                  .totalDeaths
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
                  ),
                ],
              ),
      ),
    );
  }
}
