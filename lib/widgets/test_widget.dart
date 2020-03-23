import 'package:flutter/material.dart';
import 'package:ncov_tracker/models/location_model.dart';
import 'package:ncov_tracker/pages/countrydetails_page.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/data_container.dart';
import 'package:provider/provider.dart';
import 'package:ncov_tracker/constants/const_vars.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LocationData>(context);
    return Expanded(
      child: Container(
        child: Scrollbar(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: model.locationList.length,
            itemBuilder: (context, i) {
              LocationModel loc = model.locationList[i];
              return model.searchTxt == null ||
                      model.searchTxt == "" ||
                      model.searchTxt.trim().length == 0
                  ? DataWidget(
                      loc: loc,
                      pos: i + 1,
                    )
                  : loc.country
                          .toLowerCase()
                          .contains(model.searchTxt.toLowerCase())
                      ? DataWidget(
                          loc: loc,
                          pos: i + 1,
                        )
                      : Container();
            },
          ),
        ),
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  final LocationModel loc;
  final int pos;

  DataWidget({this.loc, this.pos});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            russianViolet,
            eerieBlack,
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.black45,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: int.parse(loc.totalCases.replaceAll(',', '')) > 10
                          ? Colors.red
                          : Colors.greenAccent[100],
                    ),
                    Text(
                      '${loc.country}',
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontFamily: pBold,
                          ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${loc.newCases}',
                    style: TextStyle(
                      fontSize: 16,
                      color: loc.newCases == 'NO'
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
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              DataContainer(
                data: loc.totalCases,
                dataColor: int.parse(loc.totalCases.replaceAll(',', '')) > 10
                    ? Colors.amberAccent[100]
                    : Colors.greenAccent[100],
                type: 'Total Cases',
              ),
              DataContainer(
                data: loc.totalDeaths,
                dataColor: loc.totalDeaths == 'NONE'
                    ? Colors.greenAccent[100]
                    : int.parse(loc.totalDeaths.replaceAll(',', '')) > 10
                        ? Colors.purpleAccent[100]
                        : Colors.greenAccent[100],
                type: 'Total Deaths',
              ),
              DataContainer(
                data: loc.newDeaths,
                dataColor: loc.newDeaths == 'NO'
                    ? Colors.greenAccent[100]
                    : int.parse(loc.totalDeaths
                                .replaceAll(',', '')
                                .replaceAll('+', '')) >
                            10
                        ? Colors.purpleAccent[100]
                        : Colors.greenAccent[100],
                type: 'New Deaths',
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              DataContainer(
                data: loc.totalRecovered,
                dataColor: loc.totalRecovered == 'NONE'
                    ? Colors.amberAccent[100]
                    : int.parse(loc.totalRecovered.replaceAll(',', '')) > 10
                        ? Colors.greenAccent[100]
                        : Colors.purpleAccent[100],
                type: 'Total Recovered',
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              DataContainer(
                data: loc.seriousCritical,
                dataColor: loc.seriousCritical == 'NONE'
                    ? Colors.greenAccent[100]
                    : int.parse(loc.seriousCritical.replaceAll(',', '')) > 10
                        ? Colors.redAccent[100]
                        : Colors.greenAccent[100],
                type: 'Serious, Critical',
              ),
              DataContainer(
                data: loc.activeCases,
                dataColor: loc.activeCases == 'NONE'
                    ? Colors.greenAccent[100]
                    : int.parse(loc.activeCases.replaceAll(',', '')) > 10
                        ? Colors.redAccent[100]
                        : Colors.greenAccent[100],
                type: 'Active Cases',
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CountryDetails(
                    locationModel: loc,
                  ),
                ),
              ),
              color: deepPuce,
              splashColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'More info',
                    style: Theme.of(context).textTheme.display1.copyWith(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontFamily: pBold,
                        ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 15.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
