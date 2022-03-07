import 'dart:convert';

import 'package:aniu/models/new.dart';
import 'package:http/http.dart' as http;

Future<List> fetchNew22() async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.list.new22y'));
  // await Future.delayed(const Duration(seconds: 5));
  if(response.statusCode == 200) {
    return jsonDecode(response.body).map((jsonItem) => Release.fromJson(jsonItem)).toList();
  } else {
    throw Exception('Не удалось загрузить список Сейчас в тренде');
  }
}
Future<Release> fetchRelease(String id) async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.get?id=' + id));
  // await Future.delayed(const Duration(seconds: 5));
  if(response.statusCode == 200) {
    return Release.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Не удалось загрузить список Сейчас в тренде');
  }
}

Future<bool> checkURL(String url) async {
  final response = await http.get(Uri.parse(url));
  if(response.statusCode == 200) {
    return true;
  }
  else {
    return false;
  }
}