import 'dart:convert';

import 'package:aniu/models/objectbox/cookies.dart';
import 'package:http/http.dart' as http;

Future<bool> checkUserAccess() async{
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/account.notify.count'), headers: headers);
  if(response.statusCode == 200) {
    if (jsonDecode(response.body)['error'] == null) return true;
    return false;
  }
  else {
    return false;
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