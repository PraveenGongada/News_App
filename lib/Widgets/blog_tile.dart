import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/Screens/details_screen.dart';

class BlogTile extends StatelessWidget {
  final String urlToImg, title, desc, url;

  BlogTile({
    required this.urlToImg,
    required this.title,
    required this.desc,
    required this.url,
  });

  final browser = ChromeSafariBrowser();

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: () async {
        if (await ChromeSafariBrowser.isAvailable()) {
          await browser.open(
              url: Uri.parse(url),
              options: ChromeSafariBrowserClassOptions(
                  android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false),
                  ios: IOSSafariOptions(barCollapsingEnabled: true)));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(
                url: url,
              ),
            ),
          );
        }
      },
      child: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      placeholder: (context, loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorWidget: (context, message, errorOutlined) => Icon(
                        Icons.error_outline,
                        color: Colors.red,
                      ),
                      imageUrl: urlToImg,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  desc,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: isDarkMode ? Colors.white60 : Colors.black54,
                      fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
