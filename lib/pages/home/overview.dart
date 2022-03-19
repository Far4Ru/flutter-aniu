import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:aniu/pages/widgets/swiper.dart';
import 'package:flutter/material.dart';
import '../widgets/actions_swiper.dart';
import '../subpages/anime.dart';
import '../../helpers/column_builder.dart';

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
              const Text(
                  'Обзор',
                  style: h1Style
              ),
              const Text('Быстрые действия',
                  style: h3Style
              ),
              actionsSwiper(context),
              const Text('Сейчас в тренде',
                  style: h3Style
              ),
              swiper(context, data['popular'] ?? []),
              Container(
                color: const Color(0xff0f1422),
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
                              _toAnimePage(context, comments[index].release);
                            },
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
                                            radius: 20,
                                          ),
                                          Text(comments[index].user.login, style: titleStyle),
                                          Text(comments[index].timestamp, style: smallStyle),
                                        ],
                                      ),
                                      Text(comments[index].likesCount.toString(), style: smallStyle)
                                    ],
                                  ),
                                  Text(comments[index].message ?? '', style: smallStyle,),
                                  Text(comments[index].title, style: titleStyle,)
                                ]
                            ),
                          );
                        }
                    )
                  ],
                ),
              ),

            ],
          );
        }
      }
  );
}

void _toAnimePage(BuildContext context, String id) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnimePage(id: id)
      )
  );
}