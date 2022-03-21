import 'dart:convert';

import 'package:aniu/api/check.dart';
import 'package:aniu/api/parse.dart';
import 'package:aniu/main.dart';
import 'package:aniu/models/objectbox/cookies.dart';
import 'package:aniu/models/objectbox/user.dart';
import 'package:aniu/models/requests/comment.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:aniu/models/requests/role.dart';
import 'package:http/http.dart' as http;


Future<List> fetchReleaseList(String name) async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.list.'+name));
  if(response.statusCode == 200) {
    return jsonDecode(response.body).map((jsonItem) => Release.fromJson(jsonItem)).toList();
  } else {
    throw Exception('Не удалось загрузить список'+name);
  }
}

Future<List> fetchReleaseComments() async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.comments.last'));
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
  if(response.statusCode == 200) {
    return Release.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Не удалось загрузить список Сейчас в тренде');
  }
}

Future<List<Role>> fetchReleaseRoles(String id) async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.characters.get?id=' + id));
  if(response.statusCode == 200) {
    return jsonDecode(response.body).map((jsonItem) => Role.fromJson(jsonItem)).cast<Role>().toList();
  } else {
    throw Exception('Не удалось загрузить список персонажей');
  }
}

Future<Map<String, List>> fetchOverview() async {
  return {
    'popular' : await fetchReleaseList('popular'),
    'comments' : await fetchReleaseComments(),
    'userAccess' : [await checkUserAccess()]
  };
}

Future fetchProfile() async {
  var box = objectbox.store.box<StoredUser>();
  var user = box.getAll().first;
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  headers['User-Agent'] = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Mobile Safari/537.36';
  final response = await http.get(Uri.parse(user.url), headers: headers);
  if(response.statusCode == 200) {
    return parseProfile(response.body);
  } else {
    throw Exception('Не удалось загрузить данные профиля');
  }
}

Future fetchSearch(String searchQuery) async {
  Map<String, String> headers = {};
  headers['User-Agent'] = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Mobile Safari/537.36';
  final response = await http.get(Uri.parse("https://aniu.ru/search/"+ searchQuery), headers: headers);
  if(response.statusCode == 200) {
    return parseSearch(response.body);
  } else {
    throw Exception('Не удалось загрузить данные профиля');
  }
}