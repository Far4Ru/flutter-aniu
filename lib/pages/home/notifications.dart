import 'package:aniu/data/text_styles.dart';
import 'package:flutter/material.dart';



Widget notificationsPage(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
    child: Center(
      child: Column(
        children: const [
          Text(
            'Уведомления',
            style: h1Style,
          ),
          Text(
            'Нет новых уведомлений',
            style: smallStyle,
          ),
        ],
      ),
    ),
  );
}