import 'package:aniu/api/pages.dart';
import 'package:aniu/pages/loading_screen.dart';
import 'package:flutter/material.dart';
import '../data/values.dart';

Widget homePage(BuildContext context) {
  return FutureBuilder(
    future: fetchNew22(),
    builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data == null) {
        return LoadingScreen(context);
      }
      else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Аниме'),
            const Text('Сейчас в тренде'),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Text('Аниме');
                }
              ),
            )
          ],
        );
      }
    }
  );
}