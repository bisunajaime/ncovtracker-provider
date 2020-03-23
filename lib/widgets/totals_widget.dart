import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';

class TotalsWidget extends StatelessWidget {
  final String data;
  final String dataType;
  final Color dataColor;

  const TotalsWidget({
    Key key,
    this.data,
    this.dataType,
    this.dataColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 5.0,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.black87,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          color: eerieBlack,
        ),
        child: Column(
          children: <Widget>[
            Text(
              '$data',
              style: textTheme.title.copyWith(
                fontSize: 25.0,
                color: dataColor,
              ),
            ),
            Text(
              '$dataType',
              style: textTheme.subtitle.copyWith(
                fontSize: 13.0,
                fontFamily: pMedium,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
