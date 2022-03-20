import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/display_items.dart';
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
            const Padding(
              padding: EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
              child: Text(
                'Обзор',
                style: h1Style
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0, left: 19.0, right: 19.0),
              child: Text('Быстрые действия',
                style: h3Style
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19.0, right: 19.0),
              child: actionsSwiper(context, displayQuickActions),
            ),
            if ((data['userAccess'] ?? [false]).first) const Padding(
              padding: EdgeInsets.only(top: 5.0, left: 19.0, right: 19.0),
              child: Text('Мои списки',
                style: h3Style
              ),
            ),
            if ((data['userAccess'] ?? [false]).first) Padding(
              padding: const EdgeInsets.only(left: 19.0, right: 19.0),
              child: actionsSwiper(context, displayMyLists),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 19.0, right: 19.0),
              child: Text('Сейчас в тренде',
                style: h3Style
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19.0, right: 19.0),
              child: swiper(context, data['popular'] ?? []),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                color: const Color(0xff0f1422),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 20, right: 20, bottom: 50),
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
                              padding: index == 0 ? const EdgeInsets.only(top: 10.0) : const EdgeInsets.only(top: 50.0),
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
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(comments[index].user.login, style: titleStyle),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0),
                                            child: Text(comments[index].timestamp, style: smallStyle),
                                          ),
                                        ],
                                      ),
                                      Text(comments[index].likesCount.toString(), style: smallStyle)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(comments[index].message ?? '', style: smallStyle,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(comments[index].title, style: titleStyle,),
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