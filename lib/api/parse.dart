import 'package:aniu/api/fetch.dart';
import 'package:aniu/models/display_data/character.dart';
import 'package:aniu/models/display_data/collection.dart';
import 'package:aniu/models/display_data/dorama.dart';
import 'package:aniu/models/display_data/release.dart';
import 'package:aniu/models/display_data/top_users.dart';
import 'package:aniu/models/display_data/user.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:html/parser.dart';

parseProfile(body) {
  var document = parse(body);
  String? poster = document.getElementById('videobg')?.attributes['poster'];
  var profileContent = document.getElementById('profileContent');
  String? name =
      profileContent?.getElementsByClassName('main-title').first.innerHtml;
  String? avatar =
      profileContent?.getElementsByTagName('img').first.attributes['src'];
  var arrayTagId =
      profileContent?.getElementsByTagName('small').first.text.split(' ');
  String? tag = arrayTagId?.first;
  String? id = arrayTagId?.last;
  var row = profileContent?.getElementsByClassName('row').first;
  List? list = row?.getElementsByClassName('col-3');
  Map<String, String> stats = {
    for (var e in list ?? [])
      e.getElementsByTagName('small').first.innerHtml:
          e.getElementsByTagName('div').first.innerHtml
  };
  var data = UserDisplayData(
      name ?? '', stats, poster ?? '', avatar ?? '', tag ?? '', id ?? '');
  data.translateStats();
  return data;
}

parseSearch(body) async {
  var document = parse(body);
  var searchContent = document.getElementById('searchContent');
  List? links = searchContent
      ?.getElementsByTagName('a')
      .map((e) => e.attributes['data-release'])
      .toList();
  List<Release> animeList = [];
  for (var link in links ?? []) {
    Release anime = (await fetchRelease(link))['release'];
    if (anime.id != null) animeList.add(anime);
  }
  return animeList;
}

List<ReleaseDisplayData> parseReleaseList(body) {
  var document = parse(body);
  List<ReleaseDisplayData> releaseList = [];
  var searchContent = document.getElementsByClassName("row").first.children;

  for (var e in searchContent) {
      String? id = e.getElementsByTagName("a").first.attributes['data-release'];
      String? title = e.getElementsByTagName("a").first.attributes['title'];
      String? originalTitle = e.getElementsByTagName("a").first.attributes['data-title'];
      String? type = e.getElementsByTagName("a").first.attributes['itemtype'];
      String? year = e.getElementsByTagName("a").first.attributes['data-year'];
      String? poster = e.getElementsByTagName("img").first.attributes['src'];

      releaseList.add(ReleaseDisplayData(title!, id!, originalTitle!, type!, "ongoing", year!, poster!, ""));
  }
  return releaseList;
}

Future<String?> parseRandomRelease(body) async {
  var document = parse(body);
  String? searchContent =
      document.getElementById("content")!.attributes['data-id'];
  if (searchContent != null) {
    return searchContent;
  } else {
    return fetchRandomRelease();
  }
}

CharacterDisplayData parseCharacter(body) {
  var document = parse(body);
  var root = document.getElementById('root');
  var row = root?.getElementsByClassName('row').first;
  var divs = row?.children;
  var imageDiv = divs?.first;
  var titleDiv = divs?.last;
  var image = imageDiv?.getElementsByTagName('img').first.attributes['src'];
  var title = titleDiv?.getElementsByTagName('h1').first.innerHtml;
  var alternativeTitle =
      titleDiv?.getElementsByTagName('small').first.innerHtml;
  String? description = '';
  try {
    description = titleDiv?.getElementsByTagName('span').first.innerHtml;
  } catch (e) {
    // Нет описания
  }
  return CharacterDisplayData(
      image ?? '', title ?? '', description ?? '', alternativeTitle ?? '');
}

List<TopUsersDisplayData> parseTopUsers(body) {
  var document = parse(body);
  var root = document.getElementById('userTop');
  var li = document.getElementsByTagName('li');
  List<TopUsersDisplayData> topUsersList = [];
  for (var element in li) {
    var id = element
            .getElementsByTagName('a')
            .first
            .attributes['href']
            ?.split('/')
            .last ??
        '';
    var avatar =
        element.getElementsByTagName('img').first.attributes['src'] ?? '';
    var name = element.getElementsByTagName('strong').first.innerHtml;
    var description = element.getElementsByTagName('small').first.innerHtml;
    topUsersList.add(TopUsersDisplayData(id, avatar, name, description));
  }
  return topUsersList;
}

parseAnimePage(body) {
  var document = parse(body);
  var articles = document.body?.getElementsByTagName('article');
  List<ReleaseDisplayData> releaseList = [];
  if (articles != null) {
    for (var release in articles) {
      String id = release.attributes['id'] ?? '';
      String title = release.attributes['data-title'] ?? '';
      // print(title);
      String originalTitle = release
          .getElementsByClassName('name-en info-original')
          .first
          .innerHtml;
      String type = release.attributes['data-kind'] ?? '';
      String status = release.attributes['data-status'] ?? '';
      String year = release.attributes['data-year'] ?? '';
      String poster =
          release.getElementsByTagName('img').first.attributes['src'] ?? '';
      String ageRating = release.attributes['data-rating'] ?? '';
      releaseList.add(ReleaseDisplayData(
          title, id, originalTitle, type, status, year, poster, ageRating));
    }
  }
  return releaseList;
}

List<DoramaDisplayData> parseDoramaPage(body) {
  var document = parse(body);
  var articles = document.body?.getElementsByTagName('article');
  List<DoramaDisplayData> doramaList = [];
  if (articles != null) {
    for (var release in articles) {
      String id = release.attributes['id'] ?? '';
      String title = release.attributes['title'] ?? '';
      String info = release
          .getElementsByClassName('name-en info-original')
          .first
          .innerHtml;
      String titleEn = info.split("<br>").first;
      String type = info.split("<br>").last.split(", ").first;
      String year = info.split("<br>").last.split(", ").last;
      String poster =
          release.getElementsByTagName('img').first.attributes['src'] ?? '';
      doramaList.add(DoramaDisplayData(title, id, titleEn, type, year, poster));
    }
  }
  return doramaList;
}

parseCollectionPage(body) {
  var document = parse(body);
  var divs = document.body?.getElementsByClassName('col-xxl-2');
  List<CollectionDisplayData> collectionList = [];
  if (divs != null) {
    for (var div in divs) {
      String image =
          div.getElementsByTagName('img').first.attributes['data-src'] ?? '';
      String name =
          div.getElementsByClassName('collection-name').first.innerHtml;
      String href =
          div.getElementsByTagName('a').first.attributes['href'] ?? '';
      String favoritesCount = div
          .getElementsByClassName('collection-favorites-count')
          .first
          .innerHtml
          .trim()
          .split(' ')
          .first;
      collectionList
          .add(CollectionDisplayData(image, name, href, favoritesCount));
    }
  }
  return collectionList;
}

parseCollection(body) {
  var document = parse(body);
  var articles = document.body?.getElementsByTagName('article');
  List<ReleaseDisplayData> releaseList = [];
  if (articles != null) {
    for (var release in articles) {
      String id = release.attributes['id'] ?? '';
      String title =
          release.getElementsByClassName('name-ru info-title').first.innerHtml;
      String originalTitle = release
          .getElementsByClassName('name-en info-original')
          .first
          .innerHtml;
      String year = release
          .getElementsByClassName('name-en info-original')
          .last
          .innerHtml
          .trim();
      String poster =
          release.getElementsByTagName('img').first.attributes['src'] ?? '';
      releaseList.add(ReleaseDisplayData(
          title, id, originalTitle, '', '', year, poster, ''));
    }
  }
  var title = document.body
      ?.getElementsByTagName('h1')
      .first
      .innerHtml
      .trim()
      .split('<')
      .first
      .trim();
  var description = document.body
      ?.getElementsByClassName('col-12 col-md-12')
      .first
      .children[0]
      .innerHtml
      .replaceAll(RegExp(r'\<br>'), "\n")
      .replaceAll(RegExp(r'\<[\x00-\x7F]+\>'), "");
  return {'title': title, 'description': description, 'list': releaseList};
}
