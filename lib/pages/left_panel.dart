import 'package:flutter/material.dart';

Widget leftPanel(BuildContext context) {
  return Drawer(
    child: Container(
      color: const Color(0xff0f1422),
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          Padding(padding: EdgeInsets.only(top: 30, left: 20, bottom: 20),
            child: Text(
              'ПРОФИЛЬ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}