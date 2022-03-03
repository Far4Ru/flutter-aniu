import 'package:flutter/material.dart';
import '../data/values.dart';

Widget homePage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Аниме'),
      const Text('Сейчас в тренде'),
      Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return Text('Аниме');
            }
        ),
      )
    ],
  );
}