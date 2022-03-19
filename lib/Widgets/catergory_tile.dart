import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:news_app/Screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final String url;
  final String categorynamee;

  CategoryTile({required this.categorynamee, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Catergory(
                      categoryname: categorynamee,
                    )));
      },
      child: Container(
          child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: url,
              height: 60,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              categorynamee,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      )),
    );
  }
}
