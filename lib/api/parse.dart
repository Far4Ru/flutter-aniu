import 'package:aniu/models/display_data/user.dart';
import 'package:html/parser.dart';

parseProfile(body) {
  ///videobg
  ///div.user-info
  ///
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
  // String? name = document.body?.getElementsByClassName('user-name').first.children.first.innerHtml.trim();
  // List? list = document.body?.getElementsByClassName('col-3 text-center');
  // Map<String, int> stats = { for (var e in list ?? []) e.getElementsByTagName('small').first.innerHtml : int.parse(e.getElementsByTagName('strong').first.innerHtml) };
  var data = UserDisplayData(name ?? '', stats, poster ?? '', avatar ?? '', tag ?? '', id ?? '');
  data.translateStats();
  return data;

}