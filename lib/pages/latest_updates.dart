import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ncov_tracker/constants/const_vars.dart';
import 'package:ncov_tracker/utils/latestupdates_data.dart';
import 'package:provider/provider.dart';

class LatestUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final latestUpdates = Provider.of<LatestUpdatesData>(context);
    return Scaffold(
      backgroundColor: grayBlue,
      appBar: AppBar(
        backgroundColor: gunMetal,
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
                    backgroundColor: gunMetal,
                    valueColor: AlwaysStoppedAnimation<Color>(redPantone),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Loading',
                    style: TextStyle(
                      color: gunMetal,
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
                          fillColor: gunMetal,
                          hintText: 'Search a country',
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
                                                    mediumAppleRed,
                                                    gunMetal,
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
