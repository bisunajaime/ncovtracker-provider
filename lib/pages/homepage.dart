import 'package:flutter/material.dart';
import 'package:ncov_tracker/main.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/utils/more_results_data.dart';
import 'package:ncov_tracker/widgets/stateful_wrapper.dart';
import 'package:ncov_tracker/widgets/test_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationData>(context);
    final moreData = Provider.of<MoreResultsData>(context);
    return StatefulWrapper(
      onInit: locData.loadData,
      child: Scaffold(
        backgroundColor: Color(0xff330000),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
            )
          ],
          backgroundColor: Color(0xff3E0000),
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
                  color: Color(0xffDAACAC),
                ),
              )
            ],
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Container(
            color: Color(0xff533838),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff6B0101),
                        Color(0xff2F0000),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'nCovEr',
                        style: Theme.of(context).textTheme.title.copyWith(
                              fontSize: 25.0,
                            ),
                      ),
                      Text(
                        '${locData.countriesList.length == 0 ? 'Loading' : locData.countriesList.length} Affected Areas',
                        style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 15.0,
                              fontFamily: pMedium,
                            ),
                      ),
                      Text(
                        '${locData.date}',
                        style: Theme.of(context).textTheme.body2.copyWith(
                              color: Colors.amberAccent,
                              fontFamily: pMedium,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: locData.loadData,
          backgroundColor: Color(0xffC04848),
          child: Icon(Icons.refresh),
        ),
        body: locData.loading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Color(0xffC04848),
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff3E0000)),
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
                            color: Colors.white,
                            fontFamily: pMedium,
                          ),
                          controller: locData.controller,
                          onChanged: locData.search,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              child: Icon(
                                Icons.backspace,
                                color: Colors.white,
                              ),
                              onTap: locData.clearTxt,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: Color(0xffC04848),
                            hintText: 'Search here...',
                            hintStyle: TextStyle(
                              fontFamily: pMedium,
                              color: Colors.white,
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
                                fontFamily: pBold,
                              ),
                        )
                      ],
                    ),
                  ),
                  TestWidget(),
                ],
              ),
      ),
    );
  }
}
