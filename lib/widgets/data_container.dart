import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';

class DataContainer extends StatelessWidget {
  final String data;
  final Color dataColor;
  final String type;
  DataContainer({this.data, this.dataColor, this.type});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 2.5,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: gunMetal,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.black26,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              data,
              style: Theme.of(context).textTheme.body1.copyWith(
                    color: dataColor,
                    fontSize: 17.0,
                  ),
            ),
            Text(
              type,
              style: Theme.of(context).textTheme.body2.copyWith(
                    fontSize: 11,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
