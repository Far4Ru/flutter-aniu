import 'package:aniu/api/pages.dart';
import 'package:aniu/pages/loading_screen.dart';
import 'package:aniu/pages/swiper.dart';
import 'package:flutter/material.dart';
import '../data/values.dart';

Widget homePage(BuildContext context) {
  return FutureBuilder(
    future: fetchHome(),
    builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data == null) {
        return LoadingScreen(context);
      }
      else {
        return ListView(
          // shrinkWrap: true,
          children: [
            const Text(
                'Аниме',
              style: h1Style
            ),
            const Text('Сейчас в тренде',
                style: h3Style
            ),
            swiper(context, snap.data['popular']),
            const Text('Онгоинги',
                style: h3Style
            ),
            swiper(context, snap.data['ongoings']),
            const Text('Сериалы',
                style: h3Style
            ),
            swiper(context, snap.data['released']),
            const Text('Фильмы',
                style: h3Style
            ),
            swiper(context, snap.data['movies']),
            const Text('Последние обновленные',
                style: h3Style
            ),
            swiper(context, snap.data['new']),
            const Text('Сейчас смотрят',
                style: h3Style
            ),
            swiper(context, snap.data['now']),
          ],
        );
      }
    }
  );
}