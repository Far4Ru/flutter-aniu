import 'package:aniu/pages/player.dart';
import 'package:aniu/pages/subpages/anime.dart';
import 'package:aniu/pages/subpages/settings.dart';
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

toRandomPage() {
  // TODO: - https://aniu.ru/anime/random
}

toCollectionsPage(){
  // TODO: - collections.dart
}

toFavouritesPage(){
  // TODO: - user_lists.dart
}

toRulesPage(){
  // TODO: - rules.dart
}

toDonatePage() async {
  if (!await launch('https://my.qiwi.com/Aleksei-AIGtMGn6g6?noCache=true')) throw 'Не удается запустить страницу с пожертвованием';
}

toTopUsersPage(){
  // TODO: - top_users.dart
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