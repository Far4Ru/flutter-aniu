import 'dart:convert';

import 'package:aniu/models/new.dart';
import 'package:http/http.dart' as http;

Future<Release> fetchNew22() async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.list.new22y'));
  if(response.statusCode == 200) {
    return Release.fromJson(jsonDecode(response.body)[0]);
  } else {
    throw Exception('Не удалось загрузить список Сейчас в тренде');
  }
}