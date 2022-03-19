import 'package:flutter/material.dart';
import 'package:news_app/API/homeapi_data.dart';
import 'package:news_app/Data/category.dart';
import 'package:news_app/Data/home_data.dart';
import 'package:news_app/Widgets/blog_tile.dart';
import 'package:news_app/Widgets/catergory_tile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeInfo> news = [];
  String country = 'in';

  bool _loading = true;

  getnews() async {
    HeadLines _head = HeadLines();
    await _head.getnews(country);
    news = _head.newss;
    setState(() {
      _loading = false;
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: RichText(
          textScaleFactor: 1.5,
          text: TextSpan(
            text: 'Trending ',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: 'News',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        height: 60,
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowGlow();
                            return true;
                          },
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: cats.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: index == cats.length - 1
                                      ? EdgeInsets.only(
                                          right: 0,
                                        )
                                      : EdgeInsets.only(right: 16),
                                  child: CategoryTile(
                                    url: cats[index].imgurl,
                                    categorynamee: cats[index].title,
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Made By ',
                            style: TextStyle(
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                          Text(
                            'Praveen Kumar',
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: news.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              desc: news[index].description,
                              title: news[index].title,
                              urlToImg: news[index].urlToImage,
                              url: news[index].url,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
