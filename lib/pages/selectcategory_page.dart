import 'package:flutter/material.dart';
import 'package:ncov_tracker/pages/category_page.dart';
import 'package:ncov_tracker/pages/news_page.dart';
import 'package:ncov_tracker/utils/latestnews_data.dart';
import 'package:provider/provider.dart';

import '../constants/const_vars.dart';

class SelectCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Business',
      'Entertainment',
      'General',
      'Health',
      'Science',
      'Sports',
      'Technology',
    ];
    final latestNewsData = Provider.of<LatestNewsData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      backgroundColor: box,
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              latestNewsData.setCategory(categories[i].toLowerCase());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsPage(),
                ),
              );
            },
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                '${categories[i]}',
              ),
            ),
          );
        },
      ),
    );
  }
}
