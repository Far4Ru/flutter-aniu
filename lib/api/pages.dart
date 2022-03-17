import 'dart:convert';

import 'package:aniu/models/new.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/cookies.dart';
import '../objectbox.g.dart';

Future<List> fetchReleaseList(String name) async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.list.'+name));
  // await Future.delayed(const Duration(seconds: 5));
  if(response.statusCode == 200) {
    return jsonDecode(response.body).map((jsonItem) => Release.fromJson(jsonItem)).toList();
  } else {
    throw Exception('Не удалось загрузить список'+name);
  }
}

Future<List> fetchReleaseComments() async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.comments.last'));
  // await Future.delayed(const Duration(seconds: 5));
  if(response.statusCode == 200) {
    return jsonDecode(response.body).map((jsonItem) => Comment.fromJson(jsonItem)).toList();
  } else {
    throw Exception('Не удалось загрузить список комментариев');
  }
}

Future<Map<String, List>> fetchHome() async {
  return {
    'new': await fetchReleaseList('new'),
    'popular': await fetchReleaseList('popular'),
    'ongoings': await fetchReleaseList('ongoings'),
    'now': await fetchReleaseList('now'),
    'released': await fetchReleaseList('released'),
    'movies': await fetchReleaseList('movies'),
  };
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

Future<Map<String, List>> fetchOverview() async {
  return {
    'popular' : await fetchReleaseList('popular'),
    'comments' : await fetchReleaseComments()
  };
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

void saveCookies(String url) async {
  CookieManager cookieManager = CookieManager.instance();
  List<Cookie> cookies = await cookieManager.getCookies(url: Uri.parse(url));
  var box = objectbox.store.box<StoredCookie>();
  for (var element in cookies) {
    try {
      box.put(StoredCookie(element.name,element.value));
    }
    catch (e) {
      var storedCookie = box.query(StoredCookie_.name.equals(element.name)).build().findFirst();
      if (storedCookie != null) {
        storedCookie.value = element.value;
        // print(storedCookie?.id);
        box.put(storedCookie);
      }
    }
  }
}