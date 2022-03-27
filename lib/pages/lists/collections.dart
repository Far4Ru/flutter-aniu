import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

Widget collectionListPage(BuildContext context) {
  Map<String, List> data;

  return FutureBuilder(
      future: fetchHome(),
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.data == null) {
          return LoadingScreen(context);
        }
        else {
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
                          'Коллекции',
                          style: h1Style
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }
  );
}