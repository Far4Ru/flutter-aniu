import 'package:aniu/pages/player.dart';
import 'package:aniu/pages/subpages/anime.dart';
import 'package:aniu/pages/subpages/collections.dart';
import 'package:aniu/pages/subpages/rules.dart';
import 'package:aniu/pages/subpages/settings.dart';
import 'package:aniu/pages/subpages/top_users.dart';
import 'package:aniu/pages/subpages/user_lists.dart';
import 'package:aniu/pages/webview/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

toLoginPage(context) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage()
      )
  );
}

toRandomPage(context)  async{
  /// TODO: - Рандомное аниме
  /// https://aniu.ru/anime/random
  /// 1. Сделать запрос в ~/api/fetch.dart - Future fetchAnimeRandom()
  /// 2. Отпарсить в ~/api/parse.dart - String parseAnimeRandom(body)
  /// 3. Записать в id идентификатор аниме

  String id = '11';
  toAnimePage(context, id);
}

toCollectionsPage(context) async{
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CollectionsPage()
      )
  );
}

toFavouritesPage(context, String type) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => UserListsPage(id: type)
    )
  );
}

toRulesPage(context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => const RulesPage()
    )
  );
}

toDonatePage(context) async {
  if (!await launch('https://my.qiwi.com/Aleksei-AIGtMGn6g6?noCache=true')) throw 'Не удается запустить страницу с пожертвованием';
}

toTopUsersPage(context) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const TopUsersPage()
      )
  );
}

void toAnimePage(BuildContext context, String id) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnimePage(id: id)
      )
  );
}

void toPlayerPage(BuildContext context, String link) async {
  bool next = true; // await checkURL(link);
  if (next) {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => PlayerPage(link: link)));
  }
}

toSettingsPage(context) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const SettingsPage()
      )
  );
}