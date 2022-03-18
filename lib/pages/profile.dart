import 'package:flutter/material.dart';
import '../data/values.dart';
import 'login.dart';

Widget profilePage(BuildContext context) {
  return TextButton(
    onPressed: () => _toAnimePage(context),
    child: const Text(
      'Профиль',
      style: optionStyle,
    ),
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