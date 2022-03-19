import 'dart:convert';

import 'package:aniu/models/requests/comment.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:aniu/models/requests/role.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import '../main.dart';
import '../models/objectbox/cookies.dart';
import '../models/objectbox/user.dart';

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

Future<List<Role>> fetchReleaseRoles(String id) async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.characters.get?id=' + id));
  // await Future.delayed(const Duration(seconds: 5));
  if(response.statusCode == 200) {
    return jsonDecode(response.body).map((jsonItem) => Role.fromJson(jsonItem)).cast<Role>().toList();
  } else {
    throw Exception('Не удалось загрузить список персонажей');
  }
}

Future<Map<String, List>> fetchOverview() async {
  return {
    'popular' : await fetchReleaseList('popular'),
    'comments' : await fetchReleaseComments()
  };
}

Future fetchProfile() async {
  var box = objectbox.store.box<StoredUser>();
  var user = box.getAll().first;
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  // print(user.url);
  final response = await http.get(Uri.parse(user.url), headers: headers);
  // print(response.body);
  var document = parse(response.body);
  String? name = document.body?.getElementsByClassName('user-name').first.children.first.innerHtml.trim();
  List? list = document.body?.getElementsByClassName('col-3 text-center');
  Map<String, int> stats = { for (var e in list ?? []) e.getElementsByTagName('small').first.innerHtml : int.parse(e.getElementsByTagName('strong').first.innerHtml) };
  var userClass = UserClass(name ?? '', stats);
  return userClass;
}