import 'package:flutter/material.dart';
import 'package:ncov_tracker/pages/homepage.dart';

import 'package:ncov_tracker/pages/latest_updates.dart';
import 'package:ncov_tracker/pages/maps_page.dart';
import 'package:ncov_tracker/pages/world_totals.dart';
import 'package:ncov_tracker/utils/latestupdates_data.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'constants/const_vars.dart';

void main() {
  SyncfusionLicense.registerLicense(
      'NT8mJyc2IWhiZH1nfWN9Z2VoZ3xhZ3xhY2Fjc2tpYWJpZ2JzEh5oOTwgNjkyOj42fTE6ICY9MhMxNj06Pzc2fTY3Jn0jOw==');
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LocationData>(
            create: (context) => LocationData(),
            lazy: true,
          ),
          ChangeNotifierProvider<LatestUpdatesData>(
            create: (context) => LatestUpdatesData(),
            lazy: true,
          ),
        ],
        child: MaterialApp(
          title: 'COVID-19 CodeJ',
          debugShowCheckedModeBanner: false,
          routes: {
            'world_totals': (context) => WorldTotals(),
            'latest_updates': (context) => LatestUpdatesPage(),
            'maps': (context) => MapsPage(),
          },
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                    )
                  ],
                  fontSize: 17.0,
                  fontFamily: pBold,
                ),
                body1: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontFamily: pBold,
                ),
                body2: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontFamily: pMedium,
                ),
              )),
          home: SplashScreen(
            seconds: 5,
            image: Image(
              image: AssetImage('assets/images/launchlogo.png'),
            ),
            photoSize: 70,
            gradientBackground: LinearGradient(
              colors: [
                box,
                russianViolet,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            loadingText: Text(
              'Getting things done',
              style: TextStyle(
                fontFamily: pRegular,
                fontSize: 15,
                color: two,
              ),
            ),
            loaderColor: one,
            title: Text(
              'COVID-19 Tracker',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: pBold,
                color: dustStorm,
                fontSize: 15,
              ),
            ),
            navigateAfterSeconds: new HomePage(),
          ),
        ),
      ),
    );
  }
}
