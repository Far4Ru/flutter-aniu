import 'package:aniu/api/pages.dart';
import 'package:aniu/pages/loading_screen.dart';
import 'package:aniu/pages/swiper.dart';
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
            const Text(
                'Аниме',
              style: h1Style
            ),
            const Text('Сейчас в тренде',
                style: h3Style
            ),
            swiper(context, snap.data)
          ],
        );
      }
    }
  );
}