import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share/share.dart';

class Details extends StatefulWidget {
  final String url;

  const Details({
    required this.url,
  });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // Type webviewctrl = InAppWebViewController;
  double progress = 0.0;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.black,
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
              'Detailed ',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            Text(
              'Article',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Share.share(widget.url);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.share),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            onWebViewCreated: (webpagectrl) {
              // webviewctrl = webpagectrl;
            },
            onProgressChanged: (ctrl, _progress) {
              setState(() {
                progress = _progress / 100;
              });
            },
          ),
          progress < 1
              ? LinearProgressIndicator(
                  minHeight: 3,
                  color: Colors.blue,
                  value: progress,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
