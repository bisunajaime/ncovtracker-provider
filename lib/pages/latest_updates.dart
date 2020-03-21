import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/latestupdates_data.dart';
import 'package:ncov_tracker/utils/location_data.dart';
import 'package:ncov_tracker/widgets/stateful_wrapper.dart';
import 'package:provider/provider.dart';

class LatestUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final latestUpdates = Provider.of<LatestUpdatesData>(context);
    return Scaffold(
      backgroundColor: Color(0xff1F0000),
      appBar: AppBar(
        backgroundColor: darkRed,
        centerTitle: true,
        title: Text(
          'Latest Updates',
          style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 20.0,
                fontFamily: helveticaHv,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent[100],
        onPressed: latestUpdates.loadLatestUpdates,
        child: Icon(
          Icons.refresh,
          color: Colors.black,
        ),
      ),
      body: latestUpdates.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                //Search
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: helveticaMd,
                        ),
                        controller: latestUpdates.controller,
                        onChanged: latestUpdates.search,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.backspace,
                              color: Colors.white,
                            ),
                            onTap: latestUpdates.clearTxt,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xffC04848),
                          hintText: 'Search here...',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          'As of ${latestUpdates.date}',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontFamily: helveticaBd,
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
                                    color: Colors.redAccent[100],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    '$date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                      fontFamily: helveticaBd,
                                      color: Colors.black,
                                      shadows: [],
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
                                                  .toLowerCase())
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 5.0,
                                              ),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: lightPurple,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black,
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
                                                      fontFamily: helveticaMd,
                                                      fontSize: 13.0,
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
            ),
    );
  }
}
