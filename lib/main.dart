import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncov_tracker/pages/homepage.dart';
import 'package:ncov_tracker/pages/latest_updates.dart';
import 'package:ncov_tracker/pages/world_totals.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:provider/provider.dart';
import 'constants/const_vars.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
        ],
        child: MaterialApp(
          title: 'nCovEr',
          debugShowCheckedModeBanner: false,
          routes: {
            'world_totals': (context) => WorldTotals(),
            'latest_updates': (context) => LatestUpdatesPage(),
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
                  fontFamily: pRegular,
                ),
              )),
          home: HomePage(),
        ),
      ),
    );
  }
}
