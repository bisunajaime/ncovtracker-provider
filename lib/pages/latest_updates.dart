import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/latestupdates_data.dart';
import 'package:provider/provider.dart';

class LatestUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final latestUpdates = Provider.of<LatestUpdatesData>(context);
    return Scaffold(
      backgroundColor: eerieBlack,
      appBar: AppBar(
        backgroundColor: russianViolet,
        centerTitle: true,
        title: Text(
          'Latest Updates',
          style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 20.0,
                fontFamily: pBold,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: gunMetal,
        onPressed: latestUpdates.loadLatestUpdates,
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      body: latestUpdates.loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: russianViolet,
                    valueColor: AlwaysStoppedAnimation<Color>(deepPuce),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Loading',
                    style: TextStyle(
                      color: dustStorm,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                //Search
                Padding(
                  padding: EdgeInsets.symmetric(
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
                        controller: latestUpdates.controller,
                        onChanged: latestUpdates.search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            onTap: latestUpdates.clearTxt,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          filled: true,
                          fillColor: Color(0xff9c7c8b),
                          hintText: 'Search a country',
                          hintStyle: TextStyle(
                            fontFamily: pMedium,
                            color: Colors.white,
                            fontSize: 15,
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
                                fontSize: 17.0,
                                color: Colors.white,
                                fontFamily: pMedium,
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
                                    color: gunMetal,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    '$date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                          fontFamily: pMedium,
                                          color: antiFlashWhite,
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
                                                gradient: LinearGradient(
                                                  colors: [
                                                    deepPuce,
                                                    russianViolet,
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 5.0,
                                                    color: Colors.black87,
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
                                                      fontFamily: pRegular,
                                                      fontSize: 11.0,
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
