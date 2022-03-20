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
        // TODO: - Добавить отступы между элемнтами
        data = snap.data;
        return Padding(

          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListView(
            // shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 19.0, ),
                child: Text(
                    'Аниме',
                  style: h1Style
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 19.0,),
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
              const Text('Сериалы',
                  style: h3Style
              ),
              swiper(context, data['released'] ?? []),
              const Text('Фильмы',
                  style: h3Style
              ),
              swiper(context, data['movies'] ?? []),
              const Text('Последние обновленные',
                  style: h3Style
              ),
              swiper(context, data['new'] ?? []),
              const Text('Сейчас смотрят',
                  style: h3Style
              ),
              swiper(context, data['now'] ?? []),
            ],
          ),
        );
      }
    }
  );
}