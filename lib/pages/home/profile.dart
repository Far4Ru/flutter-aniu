import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/user.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Widget profilePage(BuildContext context) {
  final _key = GlobalKey<ScaffoldState>();
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return FutureBuilder(
    future: fetchProfile(),
    builder: (BuildContext context, AsyncSnapshot snap){
      if(snap.data == null) {
        return LoadingScreen(context);
      }
      else {
        if(snap.data is! UserDisplayData) return LoadingScreen(context);
        UserDisplayData user = snap.data;
        return ListView(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 10.0 / templateHeight),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          user.poster,
                          fit: BoxFit.cover,
                          width: width * 390 / templateWidth,
                          height: height * 390 * 0.28 / templateHeight,
                          // color: const Color(0xff6c757d), //set the desired color
                          // colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      Container(
                        height: height * 25 / templateHeight,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 5.0 / templateHeight),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width * 20.0 / templateWidth),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              user.avatar
                          ),
                          radius: 25,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: width * 20.0 / templateWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,style: h1Style),
                            Row(
                              children: [
                                Text(user.tag,style: smallStyle),
                                Padding(
                                  padding: EdgeInsets.only(left: width * 15.0 / templateWidth),
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
            Padding(
              padding: EdgeInsets.only(left: width * 20.0 / templateWidth, right: width * 20.0 / templateWidth),
              child: SizedBox(
                height: height * 100 / templateHeight,
                width: width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: user.stats.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => user.stats.keys.elementAt(index) == 'Аниме' ? toFavouritesPage(context, 'watching') : '',
                      child: Padding(
                        padding: index < 1 ? EdgeInsets.only(top: height * 20.0 / templateHeight) : EdgeInsets.only(left: width * 23.0 / templateWidth,top: height * 20.0 / templateHeight),
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
            ),
          ],
        );
      }
    },
  );
}