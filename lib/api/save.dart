
import 'dart:convert';

import 'package:aniu/models/objectbox/cookies.dart';
import 'package:http/http.dart' as http;

// https://aniu.ru/user/edit/site/save
// mobileColorTheme
// mobileColorScheme

Future changeStatus(id, type) async {
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  Map<String, String> formData = {};
  formData['type'] = type.toString();
  final response = await http.post(Uri.parse('https://aniu.ru/app/release?send&list='+id), body: formData, headers: headers);
  if (response.statusCode == 200) {
    // update == 'success'
    return jsonDecode(response.body).update;
  } else {
    throw Exception('Не удалось изменить избранное');
  }
}

Future<bool> favourite(id) async {
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  Map<String, String> formData = {};
  formData['favorite'] = 'toggle';
  final response = await http.post(Uri.parse('https://aniu.ru/app/release?send&list='+id), body: formData, headers: headers);
  if (response.statusCode == 200) {
    // update == 'success'
    return jsonDecode(response.body).isFavorite;
  } else {
    throw Exception('Не удалось изменить избранное');
  }
}