import 'package:aniu/data/values.dart';
import 'package:flutter/material.dart';

Widget Swiper(BuildContext context) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 11,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration:BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text('Аниме', style: smallStyle)
            ],
          );
        }
    ),
  );
}