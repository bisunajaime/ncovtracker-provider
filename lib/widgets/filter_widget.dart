import 'package:flutter/material.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/location_data.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    Key key,
    @required this.locData,
    @required this.filterBy,
    @required this.title,
  }) : super(key: key);

  final LocationData locData;
  final String filterBy;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locData.setFilterTitle(title);
        locData.setFilterBy(filterBy);
        locData.filterList(filterBy);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          color: locData.filterBy == filterBy ? one : box,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: locData.filterBy == filterBy ? pBold : pRegular,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
