import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ncov_tracker/pages/maps_page.dart';
import 'package:ncov_tracker/pages/world_totals.dart';
import 'package:ncov_tracker/utils/latestupdates_data.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/test_widget.dart';
import 'package:ncov_tracker/widgets/totals_widget.dart';
import 'package:provider/provider.dart';
import 'package:ncov_tracker/constants/const_vars.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final locData = Provider.of<LocationData>(context);
    final latestUpdates = Provider.of<LatestUpdatesData>(context);

    PageController pageController = PageController(
      initialPage: locData.initialPage,
      keepPage: true,
    );
    Widget _buildHome() {
      return locData.loading
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
            );
    }

    int _parseString(String data) {
      return int.parse(data.replaceAll(',', ''));
    }

    Widget _buildTotals() {
      return locData.loading
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
          : Container(
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
                        dataColor:
                            _parseString(locData.moreResults.totalCases) > 10
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
                        dataColor:
                            _parseString(locData.moreResults.totalDeaths) > 10
                                ? Colors.amberAccent
                                : Colors.greenAccent[100],
                        dataType: 'Deaths',
                      ),
                      TotalsWidget(
                        data: '${locData.moreResults.totalRecovered}',
                        dataColor:
                            _parseString(locData.moreResults.totalRecovered) >
                                    10
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
                            _parseString(locData.moreResults.totalActiveCases) >
                                    10
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
                        dataColor:
                            _parseString(locData.moreResults.totalMild) > 10
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
                        dataColor:
                            _parseString(locData.moreResults.totalMild) > 10
                                ? Colors.redAccent[100]
                                : Colors.amberAccent,
                        dataType: 'Serious / Critical',
                      ),
                      TotalsWidget(
                        data: '${locData.moreResults.totalClosedCases}',
                        dataColor:
                            _parseString(locData.moreResults.totalClosedCases) > 10
                                ? Colors.greenAccent
                                : Colors.amberAccent,
                        dataType: 'Closed',
                      ),
                    ],
                  ),
                  RatioWidget(),
                ],
              ),
            );
    }

    Widget _buildLatestUpdates() {
      return latestUpdates.loading
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
          : Column(
              children: <Widget>[
                //Search
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: pMedium,
                        ),
                        controller: latestUpdates.controller,
                        onChanged: latestUpdates.search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onTap: latestUpdates.clearTxt,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          filled: true,
                          fillColor: Color(0xff9c7c8b),
                          hintText: 'Search a country',
                          hintStyle: TextStyle(
                            fontFamily: pMedium,
                            color: Colors.white,
                            fontSize: 15,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'As of ${latestUpdates.date}',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontSize: 17.0,
                                color: Colors.white,
                                fontFamily: pMedium,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Latest News
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        cacheExtent: 10,
                        itemCount: latestUpdates.latestUpdatesModel.length,
                        itemBuilder: (context, i) {
                          var date = DateFormat.yMMMd().add_jm().format(
                              DateTime.parse(latestUpdates
                                  .latestUpdatesModel[i].date
                                  .replaceAll('newsdate', '')));
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 20.0,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: gunMetal,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    '$date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontFamily: pMedium,
                                          color: antiFlashWhite,
                                        ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    latestUpdates
                                        .latestUpdatesModel[i].newsPost.length,
                                    (x) {
                                      return latestUpdates
                                              .latestUpdatesModel[i].newsPost[x]
                                              .toLowerCase()
                                              .contains(latestUpdates.searchTxt
                                                  .toLowerCase()
                                                  .trim())
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 5.0,
                                              ),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    deepPuce,
                                                    russianViolet,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black87,
                                                  )
                                                ],
                                              ),
                                              child: Text(
                                                '${latestUpdates.latestUpdatesModel[i].newsPost[x]}',
                                                textAlign: TextAlign.justify,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle
                                                    .copyWith(
                                                      fontFamily: pRegular,
                                                      fontSize: 11.0,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            )
                                          : Container();
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                )
              ],
            );
    }

    List<Widget> _pageItems = [
      _buildHome(),
      _buildTotals(),
      _buildLatestUpdates(),
    ];

    return Scaffold(
      backgroundColor: eerieBlack,
      appBar: AppBar(
        backgroundColor: russianViolet,
        title: Column(
          children: <Widget>[
            Text(
              '${locData.initialPage == 0 ? 'Home' : locData.initialPage == 1 ? 'World Totals' : locData.initialPage == 2 ? 'Latest Updates' : null}',
              style: TextStyle(
                fontFamily: pBold,
              ),
            ),
            Text(
              '${locData.locationList.length == 0 ? 'Loading' : locData.locationList.length} Affected Areas',
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: eerieBlack,
        fixedColor: deepPuce,
        currentIndex: locData.initialPage,
        onTap: (i) {
          pageController.animateToPage(
            i,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        },
        unselectedItemColor: Colors.grey[700],
        selectedIconTheme: IconThemeData(color: deepPuce),
        unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: eerieBlack,
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontFamily: pMedium,
                fontSize: 10.0,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: eerieBlack,
            icon: Icon(
              Icons.insert_chart,
            ),
            title: Text(
              'World Totals',
              style: TextStyle(
                fontFamily: pMedium,
                fontSize: 10.0,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: eerieBlack,
            icon: Icon(
              Icons.update,
            ),
            title: Text(
              'Latest Updates',
              style: TextStyle(
                fontFamily: pMedium,
                fontSize: 10.0,
              ),
            ),
          ),
        ],
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
                      '${locData.locationList.length == 0 ? 'Loading' : locData.locationList.length} Affected Areas',
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
                onPressed: () {
                  locData.setInitialPage(0);
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                color: gunMetal,
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.orangeAccent[100],
                  ),
                  title: Text(
                    'Home',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: pMedium,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  locData.setInitialPage(1);
                  pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                color: gunMetal,
                child: ListTile(
                  leading: Icon(
                    Icons.insert_chart,
                    color: Colors.pinkAccent[100],
                  ),
                  title: Text(
                    'World Totals',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: pMedium,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  locData.setInitialPage(2);
                  pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                  );
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                color: gunMetal,
                child: ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Colors.blueAccent[100],
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
      floatingActionButton: locData.loading || latestUpdates.loading
          ? null
          : FloatingActionButton(
              onPressed: () {
                locData.fetchData();
                latestUpdates.fetchUpdates();
                pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                );
              },
              backgroundColor: dustStorm,
              child: Icon(
                Icons.refresh,
                color: gunMetal,
              ),
            ),
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (i) {
          locData.setInitialPage(i);
        },
        itemCount: _pageItems.length,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return _pageItems[i];
        },
      ),
    );
  }
}
