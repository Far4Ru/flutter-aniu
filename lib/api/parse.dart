import 'package:aniu/api/fetch.dart';
import 'package:aniu/models/display_data/character.dart';
import 'package:aniu/models/display_data/user.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:html/parser.dart';

parseProfile(body) {
  var document = parse(body);
  String? poster = document.getElementById('videobg')?.attributes['poster'];
  var profileContent = document.getElementById('profileContent');
  String? name = profileContent?.getElementsByClassName('main-title').first.innerHtml;
  String? avatar = profileContent?.getElementsByTagName('img').first.attributes['src'];
  var arrayTagId = profileContent?.getElementsByTagName('small').first.text.split(' ');
  String? tag = arrayTagId?.first;
  String? id = arrayTagId?.last;
  var row = profileContent?.getElementsByClassName('row').first;
  List? list = row?.getElementsByClassName('col-3');
  Map<String, int> stats = { for (var e in list ?? []) e.getElementsByTagName('small').first.innerHtml : int.parse(e.getElementsByTagName('div').first.innerHtml) };
  var data = UserDisplayData(name ?? '', stats, poster ?? '', avatar ?? '', tag ?? '', id ?? '');
  data.translateStats();
  return data;

}

parseSearch(body) async {
  var document = parse(body);
  var searchContent = document.getElementById('searchContent');
  List? links = searchContent?.getElementsByTagName('a').map((e) => e.attributes['data-release']).toList();
  List<Release> animeList = [];
  for(var link in links ?? []) {
    Release anime = await fetchRelease(link);
    if (anime.id != null) animeList.add(anime);
  }
  return animeList;
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
  var alternativeTitle = titleDiv?.getElementsByTagName('small').first.innerHtml;
  String? description = '';
  try {
    description = titleDiv
        ?.getElementsByTagName('span')
        .first
        .innerHtml;
  } catch (e) {
    // Нет описания
  }
  return CharacterDisplayData(image??'',title??'',alternativeTitle??'',description??'');
}
