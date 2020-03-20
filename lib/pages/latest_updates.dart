import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:provider/provider.dart';

class LatestUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationData>(context);
    return Scaffold(
      backgroundColor: darkRed,
      appBar: AppBar(
        backgroundColor: darkRed,
        centerTitle: true,
        title: Column(
          children: <Widget>[
            Text(
              'Latest Updates',
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
      ),
    );
  }
}
