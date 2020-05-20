import 'package:flutter/material.dart';
import 'package:ncov_tracker/pages/category_page.dart';
import 'package:ncov_tracker/pages/news_page.dart';
import 'package:ncov_tracker/utils/latestnews_data.dart';
import 'package:provider/provider.dart';

import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';
import '../constants/const_vars.dart';

class SelectCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Covid',
      'Science',
      'Sports',
      'Technology',
      'Health',
      'Business',
      'Entertainment',
      'General',
    ];
    final latestNewsData = Provider.of<LatestNewsData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Category',
          style: TextStyle(
            fontFamily: pMedium,
          ),
        ),
        backgroundColor: box,
        centerTitle: true,
      ),
      backgroundColor: box,
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              latestNewsData.setCategory(categories[i].toLowerCase());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsPage(
                    category: categories[i],
                  ),
                ),
              );
            },
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/${categories[i].toLowerCase()}.jpg',
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '${categories[i]}',
                style: TextStyle(
                  fontFamily: pBold,
                  fontSize: 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
