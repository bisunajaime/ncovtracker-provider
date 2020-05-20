import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ncov_tracker/models/latestnews_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';

class NewsInfo extends StatelessWidget {
  final ArticlesList article;

  NewsInfo({this.article});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.author,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: box,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Hero(
            tag: article.urlToImage,
            child: Container(
              width: 100,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    article.urlToImage,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  article.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: pBold,
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                DateFormat.yMd().add_jm().format(
                      DateTime.parse(
                        article.publishedAt,
                      ),
                    ),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: pRegular,
                  color: Colors.amberAccent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  article.content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: pRegular,
                    fontSize: 11,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => _launchInBrowser(article.url),
                color: Colors.blueAccent,
                child: Text(
                  'View full article',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
