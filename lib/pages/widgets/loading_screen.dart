import 'package:flutter/material.dart';

Widget LoadingScreen(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Scaffold(
    backgroundColor: const Color(0xff0c101b),
    body: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: height / 3),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(
              child: CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                (Color(0xFFCA3131)))),
                width: 44,
                height: 44,
            ),
          ]
      ),
    ),
  );
}