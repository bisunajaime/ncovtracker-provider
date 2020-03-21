import 'package:flutter/material.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/stateful_wrapper.dart';
import 'package:ncov_tracker/widgets/test_widget.dart';
import 'package:provider/provider.dart';
import 'package:ncov_tracker/constants/const_vars.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationData>(context);
    return Scaffold(
      backgroundColor: Color(0xff330000),
      appBar: AppBar(
        backgroundColor: Color(0xff3E0000),
        title: Column(
          children: <Widget>[
            Text(
              'nCovEr',
              style: TextStyle(
                fontFamily: helveticaBd,
              ),
            ),
            Text(
              '${locData.countriesList.length == 0 ? 'Loading' : locData.countriesList.length} Affected Areas',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: helveticaMd,
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
                            fontSize: 30.0,
                          ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${locData.countriesList.length == 0 ? 'Loading' : locData.countriesList.length} Affected Areas',
                      style: Theme.of(context).textTheme.body1.copyWith(
                            fontSize: 15.0,
                            fontFamily: helveticaMd,
                          ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${locData.date}',
                      style: Theme.of(context).textTheme.body2.copyWith(
                            color: Colors.amberAccent,
                            fontFamily: helveticaMd,
                          ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () => locData.loading
                    ? null
                    : Navigator.pushNamed(context, 'world_totals'),
                color: Color(0xff2F0000),
                child: ListTile(
                  leading: Icon(
                    Icons.insert_chart,
                    color: Colors.orangeAccent[100],
                  ),
                  title: Text(
                    '${locData.loading ? 'Loading ' : ''}World Totals',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: helveticaMd,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, 'latest_updates'),
                color: Color(0xff2F0000),
                child: ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Colors.lightBlueAccent[100],
                  ),
                  title: Text(
                    'Latest Updates',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: helveticaMd,
                        ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                color: Color(0xff2F0000),
                child: ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.greenAccent[100],
                  ),
                  title: Text(
                    'Maps',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: helveticaMd,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              MaterialButton(
                onPressed: () {},
                color: Color(0xff2F0000),
                child: ListTile(
                  leading: Icon(
                    Icons.copyright,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Copyright',
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: helveticaMd,
                        ),
                  ),
                ),
              ),
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
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xff3E0000)),
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
                          fontFamily: helveticaMd,
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
                          hintText: 'Search a country',
                          hintStyle: TextStyle(
                            fontFamily: helveticaMd,
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
                              fontFamily: helveticaBd,
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
