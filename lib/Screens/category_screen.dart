import 'package:flutter/material.dart';
import 'package:news_app/API/search_api.dart';

import 'package:news_app/Data/search_data.dart';
import 'package:news_app/Widgets/blog_tile.dart';

class Catergory extends StatefulWidget {
  final String categoryname;
  Catergory({required this.categoryname});

  @override
  _CatergoryState createState() => _CatergoryState();
}

class _CatergoryState extends State<Catergory> {
  List<CategoryInfo> catnewss = [];
  bool _isLoading = true;

  void getnews() async {
    CategoryNews news = CategoryNews();
    await news.getcatnews(widget.categoryname.toLowerCase());
    catnewss = news.catnews;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getnews();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        actionsIconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.categoryname,
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            Text(
              ' News',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.share,
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: catnewss.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                  urlToImg: catnewss[index].urlToImage,
                                  title: catnewss[index].title,
                                  desc: catnewss[index].description,
                                  url: catnewss[index].url);
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
