import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:ncov_tracker/models/latestnews_model.dart';
import 'package:ncov_tracker/pages/newsinfo_page.dart';
import 'package:ncov_tracker/utils/latestnews_data.dart';
import 'package:provider/provider.dart';

import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final latestNewsData = Provider.of<LatestNewsData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latest News',
        ),
        backgroundColor: box,
      ),
      backgroundColor: five,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: RefreshIndicator(
                onRefresh: () async {
                  latestNewsData.refresh();
                  latestNewsData.getLatestNews();
                },
                child: FutureBuilder(
                  future: latestNewsData.getLatestNews(),
                  builder: (BuildContext context,
                      AsyncSnapshot<LatestNewsModel> snapshot) {
                    print(snapshot.connectionState);
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              LoadingBouncingGrid.circle(
                                backgroundColor: one,
                                size: 50,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Getting the \nlatest news',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: pRegular,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                        break;
                      case ConnectionState.done:
                        return NewsWidget(
                          latestNewsModel: snapshot.data,
                        );
                        break;
                      default:
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              LoadingBouncingGrid.circle(
                                backgroundColor: one,
                                size: 50,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Getting the \nlatest news',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: pRegular,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Text(
                'Powered by NewsAPI.org',
                style: TextStyle(
                  fontFamily: pRegular,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  final LatestNewsModel latestNewsModel;

  NewsWidget({this.latestNewsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: latestNewsModel.articlesList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  ArticlesList article = latestNewsModel.articlesList[i];
                  return Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: box,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 100,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        article.title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: pRegular,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            article.author.contains('http')
                                                ? 'No Author'
                                                : article.author,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: pRegular,
                                            ),
                                          ),
                                          Text(
                                            DateFormat.yMd().add_jm().format(
                                                  DateTime.parse(
                                                    article.publishedAt,
                                                  ),
                                                ),
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: pRegular,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsInfo(
                                              article: article,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Container(
                                            width: double.infinity,
                                            height: 20,
                                            child: Text(
                                              'Learn more',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5,
                        top: 0,
                        bottom: 0,
                        child: Hero(
                          tag: article.urlToImage,
                          child: Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  article.urlToImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
