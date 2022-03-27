import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:aniu/pages/widgets/swiper.dart';
import 'package:flutter/material.dart';

Widget homePage(BuildContext context) {
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
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 14.0, ),
                    child: Text(
                        'Аниме',
                        style: h1Style
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0,),
                    child: Text('Сейчас в тренде',
                        style: h3Style
                    ),
                  ),
                  swiper(context, data['popular'] ?? []),
                  const Padding(
                    padding: EdgeInsets.only(top: 19.0,),
                    child: Text('Онгоинги',
                        style: h3Style
                    ),
                  ),
                  swiper(context, data['ongoings'] ?? []),
                  const Padding(
                    padding: EdgeInsets.only(top: 19.0,),
                    child: Text('Сериалы',
                        style: h3Style
                    ),
                  ),
                  swiper(context, data['released'] ?? []),
                  const Padding(
                    padding: EdgeInsets.only(top: 19.0,),
                    child: Text('Фильмы',
                        style: h3Style
                    ),
                  ),
                  swiper(context, data['movies'] ?? []),
                  const Padding(
                    padding: EdgeInsets.only(top: 19.0,),
                    child: Text('Последние обновленные',
                        style: h3Style
                    ),
                  ),
                  swiper(context, data['new'] ?? []),
                  const Padding(
                    padding: EdgeInsets.only(top: 19.0,),
                    child: Text('Сейчас смотрят',
                        style: h3Style
                    ),
                  ),
                  swiper(context, data['now'] ?? []),
                ],
              ),
            ),
          ],
        );
      }
    }
  );
}