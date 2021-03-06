import 'dart:convert';

import 'package:aniu/api/check.dart';
import 'package:aniu/api/parse.dart';
import 'package:aniu/main.dart';
import 'package:aniu/models/display_data/character.dart';
import 'package:aniu/models/display_data/top_users.dart';
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

Future<Map<String, dynamic>> fetchRelease(String id) async {
  final response = await http.get(Uri.parse('https://aniu.ru/api/v1/release.get?id=' + id));
  if(response.statusCode == 200) {
    // return Release.fromJson(jsonDecode(response.body));
    return {
      'list': await fetchReleaseUserList(id),
      'release': Release.fromJson(jsonDecode(response.body)),
      'links': await fetchLinks(id)
    };
  } else {
    throw Exception('Не удалось загрузить список Сейчас в тренде');
  }
}

Future<String?> fetchRandomRelease() async {
  final response = await http.get(Uri.parse('https://anixart.ru/anime/random'));
  if(response.statusCode == 200) {
    return parseRandomRelease(response.body);
  } else {
    throw Exception('Не удалось загрузить cлучайное аниме');
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
    throw Exception('Не удалось загрузить данные поиска');
  }
}

Future<CharacterDisplayData> fetchCharacter(String id) async {
  final response = await http.get(Uri.parse("https://aniu.ru/character/"+ id));
  if(response.statusCode == 200) {
    return parseCharacter(response.body);
  } else {
    throw Exception('Не удалось загрузить данные персонажа');
  }
}

Future<List<TopUsersDisplayData>> fetchTopUsers() async {
  Map<String, String> headers = {};
  headers['User-Agent'] = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Mobile Safari/537.36';
  final response = await http.get(Uri.parse("https://aniu.ru/user/"), headers: headers);
  if(response.statusCode == 200) {
    return parseTopUsers(response.body);
  } else {
    throw Exception('Не удалось загрузить данные персонажа');
  }
}

Future fetchUser(id) async {
  Map<String, String> headers = {};
  headers['User-Agent'] = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Mobile Safari/537.36';
  final response = await http.get(Uri.parse("https://aniu.ru/user/" + id), headers: headers);
  if(response.statusCode == 200) {
    return parseProfile(response.body);
  } else {
    throw Exception('Не удалось загрузить данные пользователя');
  }
}

Future fetchReleaseUserList(id) async {
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  final response = await http.post(Uri.parse('https://aniu.ru/app/release?list='+id), headers: headers);
  if (response.statusCode == 200) {
    // update == 'success'
    if(response.body == '') return 'false';
    return jsonDecode(response.body)['list'];
  } else {
    throw Exception('Не удалось загрузить список пользователя для релиза');
  }
}

Future fetchUserList(String type) async {
  Map<String, String> headers = {};
  headers['cookie'] = StoredCookies().toString();
  headers['User-Agent'] = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.74 Mobile Safari/537.36';
  final response = await http.get(Uri.parse("https://aniu.ru/user/?list=" + type), headers: headers);
  if(response.statusCode == 200) {
    return parseReleaseList(response.body);
  } else {
    throw Exception('Не удалось загрузить данные пользователя');
  }
}

Future fetchLinks(id) async {
  final response = await http.post(Uri.parse('https://aniu.ru/api/v1/release.links?id='+id));
  Map links = {};
  if (response.statusCode == 200) {
    // update == 'success'
    var linkList = [];
    if(jsonDecode(response.body)['links'] != null) {
      links['links'] = jsonDecode(response.body)['links'];
      for (var link in links['links']) {
        linkList.add(Release.fromJson(link));
      }
    }
    links['links'] = linkList;
    var relatedList = [];
    if(jsonDecode(response.body)['related'] != null && jsonDecode(response.body)['related'] != false) {
      links['related'] = jsonDecode(response.body)['related'];
      for (var related in links['related']) {
        relatedList.add(Release.fromJson(related));
      }
    }
    links['related'] = relatedList;
    return links;
  } else {
    throw Exception('Не удалось загрузить список пользователя для релиза');
  }
}

Future fetchAnimePage(int pageNumber) async {
  final response = await http.get(Uri.parse("https://aniu.ru/anime?page=" + pageNumber.toString() + "&"));
  if(response.statusCode == 200) {
    return parseAnimePage(response.body);
  } else {
    throw Exception('Не удалось загрузить страницу аниме');
  }
}

Future fetchDoramaPage(int pageNumber) async {
  final response = await http.get(Uri.parse("https://aniu.ru/anime/dorama?page=" + pageNumber.toString() + "&"));
  if(response.statusCode == 200) {
    return parseDoramaPage(response.body);
  } else {
    throw Exception('Не удалось загрузить страницу дорам');
  }
}

Future fetchCollectionPage(int pageNumber) async {
  final response = await http.get(Uri.parse("https://aniu.ru/collection?page=" + pageNumber.toString()));
  if(response.statusCode == 200) {
    return parseCollectionPage(response.body);
  } else {
    throw Exception('Не удалось загрузить страницу коллекций');
  }
}

Future fetchCollection(String href) async {

  final response = await http.get(Uri.parse("https://aniu.ru/" + href));
  if(response.statusCode == 200) {
    return parseCollection(response.body);
  } else {
    throw Exception('Не удалось загрузить страницу коллекций');
  }
}