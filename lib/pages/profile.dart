import 'package:flutter/material.dart';
import '../data/values.dart';
import 'login.dart';

Widget profilePage(BuildContext context) {
  _toAnimePage(context);
  return const Text(
    'Профиль',
    style: optionStyle,
  );
}

void _toAnimePage(BuildContext context) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage()
      )
  );
}