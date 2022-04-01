import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/display_items.dart';
import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/widgets/actions_swiper.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:aniu/pages/widgets/swiper.dart';
import 'package:flutter/material.dart';

Widget overviewPage(BuildContext context) {
  Map<String, List> data;
  List comments;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return FutureBuilder(
    future: fetchOverview(),
    builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data == null) {
        return LoadingScreen(context);
      }
      else {
        data = snap.data;
        comments = data['comments'] ?? [];
        return ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 14.0 / templateHeight, left: width * 19.0 / templateHeight, right: width * 19.0 / templateHeight),
              child: const Text(
                'Обзор',
                style: h1Style
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 5.0 / templateHeight, left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
              child: const Text('Быстрые действия',
                style: h3Style
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
              child: actionsSwiper(context, displayQuickActions),
            ),
            if ((data['userAccess'] ?? [false]).first) Padding(
              padding: EdgeInsets.only(top: height * 5.0 / templateHeight, left: width * 19.0/ templateWidth, right: width * 19.0 / templateWidth),
              child: const Text('Мои списки',
                style: h3Style
              ),
            ),
            if ((data['userAccess'] ?? [false]).first) Padding(
              padding: EdgeInsets.only(left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
              child: actionsSwiper(context, displayMyLists),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 20.0 / templateHeight, left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
              child: const Text('Сейчас в тренде',
                style: h3Style
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
              child: swiper(context, data['popular'] ?? []),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 20.0 / templateHeight),
              child: Container(
                color: const Color(0xff0f1422),
                child: Padding(
                  padding: EdgeInsets.only(top: height * 25.0 / templateHeight, left: width * 20 / templateWidth, right: width * 20 / templateWidth, bottom: height * 50 / templateHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Последние комментарии',
                        style: h3Style
                      ),
                      ColumnBuilder(
                        key: _scaffoldKey,
                        itemCount: comments.length,
                        itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                            onTap: (){
                              toAnimePage(context, comments[index].release);
                            },
                            child: Padding(
                              padding: index == 0 ? EdgeInsets.only(top: height * 10.0 / templateHeight) : EdgeInsets.only(top: height * 50.0 / templateHeight),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                comments[index].user.avatar
                                            ),
                                            radius: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width * 10.0 / templateWidth),
                                            child: Text(comments[index].user.login, style: titleStyle),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: width * 10.0 / templateWidth),
                                            child: Text(comments[index].timestamp, style: smallStyle),
                                          ),
                                        ],
                                      ),
                                      Text(comments[index].likesCount.toString(), style: smallStyle)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height * 15.0 / templateHeight),
                                    child: Text(
                                      comments[index]
                                        .message
                                        .replaceAll(RegExp(r'\<br>'), "\n")
                                        .replaceAll(RegExp(r'\<[\x00-\x7F]+\>'), "")
                                        .replaceAll(RegExp(r'\&quot\;'), '"')
                                        ?? '',
                                      style: smallStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height * 15.0 / templateHeight),
                                    child: Text(comments[index].title ?? '', style: titleStyle,),
                                  )
                                ]
                              ),
                            ),
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    }
  );
}