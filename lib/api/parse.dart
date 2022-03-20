import 'package:aniu/models/objectbox/user.dart';
import 'package:html/parser.dart';

parseProfile(body) {
  var document = parse(body);
  String? name = document.body?.getElementsByClassName('user-name').first.children.first.innerHtml.trim();
  List? list = document.body?.getElementsByClassName('col-3 text-center');
  Map<String, int> stats = { for (var e in list ?? []) e.getElementsByTagName('small').first.innerHtml : int.parse(e.getElementsByTagName('strong').first.innerHtml) };
  return UserClass(name ?? '', stats);
}