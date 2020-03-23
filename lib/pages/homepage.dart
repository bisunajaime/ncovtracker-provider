import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncov_tracker/pages/maps_page.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/test_widget.dart';
import 'package:provider/provider.dart';
import 'package:ncov_tracker/constants/const_vars.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final locData = Provider.of<LocationData>(context);
    return Scaffold(
      backgroundColor: eerieBlack,
      appBar: AppBar(
        backgroundColor: russianViolet,
        title: Column(
          children: <Widget>[
            Text(
              'nCovEr',
              style: TextStyle(
                fontFamily: pBold,
              ),
            ),
            Text(
              '${locData.countriesList.length == 0 ? 'Loading' : locData.countriesList.length} Affected Areas',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: pMedium,
                color: dustStorm,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: eerieBlack,
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: eerieBlack,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'nCovEr',
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 30.0,
                          ),
                    ),
                    Text(
                      '${locData.countriesList.length == 0 ? 'Loading' : locData.countriesList.length} Affected Areas',
                      style: Theme.of(context).textTheme.body1.copyWith(
                            fontSize: 15.0,
                            color: deepPuce,
                            fontFamily: pMedium,
                          ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${locData.date}',
                      style: Theme.of(context).textTheme.body2.copyWith(
                            color: antiFlashWhite,
                            fontFamily: pBold,
                          ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () => locData.loading
                    ? null
                    : Navigator.pushNamed(context, 'world_totals'),
                color: gunMetal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListTile(
                  leading: locData.loading
                      ? CircularProgressIndicator(
                          backgroundColor: russianViolet,
                          valueColor: AlwaysStoppedAnimation<Color>(deepPuce),
                        )
                      : Icon(
                          Icons.insert_chart,
                          color: Colors.orangeAccent[100],
                        ),
                  title: Text(
                    '${locData.loading ? 'Loading ' : ''}World Totals',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: pMedium,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, 'latest_updates'),
                color: gunMetal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Colors.lightBlueAccent[100],
                  ),
                  title: Text(
                    'Latest Updates',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: pMedium,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapsPage(
                      locationData: locData.locationList,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                color: gunMetal,
                child: ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.greenAccent[100],
                  ),
                  title: Text(
                    'Maps',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: pMedium,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: locData.loading
          ? null
          : FloatingActionButton(
              onPressed: locData.loadData,
              backgroundColor: dustStorm,
              child: Icon(
                Icons.refresh,
                color: gunMetal,
              ),
            ),
      body: locData.loading
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
            ))
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        style: TextStyle(
                          color: antiFlashWhite,
                          fontFamily: pMedium,
                          fontSize: 15.0,
                        ),
                        controller: locData.controller,
                        onChanged: locData.search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.backspace,
                              color: antiFlashWhite,
                              size: 20.0,
                            ),
                            onTap: locData.clearTxt,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: antiFlashWhite,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Color(0xff9c7c8b),
                          hintText: 'Search a country',
                          hintStyle: TextStyle(
                            fontFamily: pMedium,
                            color: antiFlashWhite,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff5433FF),
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                        ),
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'As of ${locData.date}',
                        style: Theme.of(context).textTheme.body2.copyWith(
                              fontFamily: pMedium,
                              fontSize: 17.0,
                            ),
                      )
                    ],
                  ),
                ),
                TestWidget(),
              ],
            ),
    );
  }
}
