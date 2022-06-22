import 'dart:async';

import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:aniu/pages/widgets/swiper.dart';
import 'package:flutter/material.dart';

Widget homePage(BuildContext context, StreamController streamController) {
  Map<String, List> data;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  load() async {
    streamController.add(await fetchHome());
  }
  load();

  return StreamBuilder(
    stream: streamController.stream,
    builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data == null) {
        return LoadingScreen(context);
      }
      else {
        data = snap.data;
        return RefreshIndicator(
          onRefresh: () => load(),
          child: ListView(
            // shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 14.0 / templateHeight),
                      child: const Text(
                          'Аниме',
                          style: h1Style
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 5.0 / templateHeight),
                      child: const Text('Сейчас в тренде',
                          style: h3Style
                      ),
                    ),
                    swiper(context, data['popular'] ?? []),
                    Padding(
                      padding: EdgeInsets.only(top: height * 19.0 / templateHeight),
                      child: const Text('Онгоинги',
                          style: h3Style
                      ),
                    ),
                    swiper(context, data['ongoings'] ?? []),
                    Padding(
                      padding: EdgeInsets.only(top: height * 19.0 / templateHeight),
                      child: const Text('Сериалы',
                          style: h3Style
                      ),
                    ),
                    swiper(context, data['released'] ?? []),
                    Padding(
                      padding: EdgeInsets.only(top: height * 19.0 / templateHeight),
                      child: const Text('Фильмы',
                          style: h3Style
                      ),
                    ),
                    swiper(context, data['movies'] ?? []),
                    Padding(
                      padding: EdgeInsets.only(top: height * 19.0 / templateHeight),
                      child: const Text('Последние обновленные',
                          style: h3Style
                      ),
                    ),
                    swiper(context, data['new'] ?? []),
                    Padding(
                      padding: EdgeInsets.only(top: height * 19.0 / templateHeight),
                      child: const Text('Сейчас смотрят',
                          style: h3Style
                      ),
                    ),
                    swiper(context, data['now'] ?? []),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  );
}