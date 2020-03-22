import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/widgets/maps_widget.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: smokyBlack,
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
        backgroundColor: eerieBlack,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: MapsWidget(),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: Text('Map Data'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
