import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:aniu/pages/router.dart';
import 'package:flutter/material.dart';

Widget searchCard(BuildContext context, Release release) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Padding(
    padding: EdgeInsets.only(left: width * 13.0 / templateWidth, top: height * 8.0 / templateHeight),
    child: GestureDetector(
      onTap: (){
        toAnimePage(context, release.id ?? '');
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://aniu.ru/posters/"+(release.poster ?? '') +".jpg",
              fit: BoxFit.cover,
              width: width * 120 / templateWidth,
              height: height * 120 / templateHeight * 1.456,
            ),
          ),
          Container(
            width: width * 120 / templateWidth,
            height: height * 40 / templateHeight,
            child: Text(
                release.titleRu ?? '',
                style: smallStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis
            ),
          )
        ],
      ),
    ),
  );
}