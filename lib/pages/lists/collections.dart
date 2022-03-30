import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/models/display_data/collection.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

Widget collectionListPage(BuildContext context) {
  final _key = GlobalKey<ScaffoldState>();
  List<CollectionDisplayData> data;

  return FutureBuilder(
      future: fetchCollectionPage(1),
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.data == null) {
          return LoadingScreen(context);
        }
        else {
          if(snap.data is! List<CollectionDisplayData>) return LoadingScreen(context);
          data = snap.data;
          return ListView(
            // shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
                    child: Text(
                        'Коллекции',
                        style: h1Style
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ColumnBuilder(
                      // scrollDirection: Axis.vertical,
                      itemCount: data.length ~/2,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                            children: [
                              if (2 * index < data.length) collectionCard(context, data[2 * index]),
                              if (2 * index + 1 < data.length) collectionCard(context, data[2 * index + 1]),
                            ]
                        );
                      }, key: _key,
                    ),
                  )
                ],
              ),
            ],
          );
        }
      }
  );
}

Widget collectionCard(BuildContext context, CollectionDisplayData release) {
  return Padding(
    padding: const EdgeInsets.only(left: 13.0, top: 8.0),
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
              width: 190,
              height: 190 / 1.77,
            ),
          ),
          Container(
            width: 190,
            height: 40,
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