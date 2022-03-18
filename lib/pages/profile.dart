import 'package:flutter/material.dart';
import '../api/pages.dart';
import '../data/values.dart';
import '../models/user.dart';
import 'loading_screen.dart';
import 'login.dart';

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