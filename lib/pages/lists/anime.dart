import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/models/display_data/release.dart';
import 'package:aniu/pages/widgets/animeCard.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

Widget animeListPage(BuildContext context) {
  final _key = GlobalKey<ScaffoldState>();
  List<ReleaseDisplayData> data;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return FutureBuilder(
      future: fetchAnimePage(1),
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.data == null) {
          return LoadingScreen(context);
        }
        else {
          if(snap.data is! List<ReleaseDisplayData>) return LoadingScreen(context);
          data = snap.data;
          return ListView(
            // shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19.0, right: 19.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 14.0, ),
                      child: Text(
                          'Аниме',
                          style: h1Style
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ColumnBuilder(
                  // scrollDirection: Axis.vertical,
                  itemCount: data.length ~/3,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        if (3 * index < data.length) animeCard(context, data[3 * index]),
                        if (3 * index + 1 < data.length) animeCard(context, data[3 * index + 1]),
                        if (3 * index + 2 < data.length) animeCard(context, data[3 * index + 2]),
                      ]
                    );
                  }, key: _key,
                ),
              )
            ],
          );
        }
      }
  );
}