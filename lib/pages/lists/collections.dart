import 'dart:async';

import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/models/display_data/collection.dart';
import 'package:aniu/pages/widgets/collectionCard.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

Widget collectionListPage(BuildContext context, StreamController streamController) {
  final _key = GlobalKey<ScaffoldState>();
  List<CollectionDisplayData> data;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return FutureBuilder(
      future: fetchCollectionPage(0),
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
                      itemCount: data.length < 2 ? data.length : data.length ~/ 2 + 1,
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

