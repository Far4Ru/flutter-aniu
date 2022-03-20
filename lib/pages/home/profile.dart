import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/objectbox/user.dart';
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
        UserClass user = snap.data;
        return Column(
          children: [
            Text(user.name,style: h1Style,),
            Container(
              height: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: user.stats.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text(user.stats.keys.elementAt(index),style: titleStyle,),
                      Text(user.stats.values.elementAt(index).toString(), style: titleStyle,)
                    ],
                  );
                }
              ),
            )
          ],
        );
      }
    },
  );
}