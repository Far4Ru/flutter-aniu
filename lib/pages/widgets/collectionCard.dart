import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/collection.dart';
import 'package:aniu/pages/router.dart';
import 'package:flutter/material.dart';

Widget collectionCard(BuildContext context, CollectionDisplayData release) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Padding(
    padding: EdgeInsets.only(left: width * 13.0 / templateWidth, top: height * 8.0 / templateHeight),
    child: GestureDetector(
      onTap: (){
        toCollectionPage(context, release.href);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              release.image,
              fit: BoxFit.cover,
              width: width * 190 / templateWidth,
              height: height * 190 / 1.77 / templateHeight,
            ),
          ),
          SizedBox(
            width: width * 190 / templateWidth,
            height: height * 40 / templateHeight,
            child: Text(
                release.name,
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