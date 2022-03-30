import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/user.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

Widget profilePage(BuildContext context) {
  return FutureBuilder(
    future: fetchProfile(),
    builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data == null) {
        return LoadingScreen(context);
      }
      else {
        UserDisplayData user = snap.data;
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        user.poster,
                        fit: BoxFit.cover,
                        width: 390,
                        height: 390 * 0.28,
                        // color: const Color(0xff6c757d), //set the desired color
                        // colorBlendMode: BlendMode.darken,
                      ),
                    ),
                    Container(
                      height: 25,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              user.avatar
                          ),
                          radius: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,style: h1Style),
                            Row(
                              children: [
                                Text(user.tag,style: smallStyle),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text('ID: ' + user.id, style: smallStyle),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: user.stats.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => user.stats.keys.elementAt(index) == 'Аниме' ? toFavouritesPage(context, 'Смотрю') : '',
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23.0,top: 20.0),
                      child: Column(
                        children: [
                          Text(user.stats.keys.elementAt(index),style: titleStyle,),
                          Text(user.stats.values.elementAt(index).toString(), style: titleStyle,)
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }
    },
  );
}