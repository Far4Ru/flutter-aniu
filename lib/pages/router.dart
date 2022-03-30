import 'package:aniu/api/fetch.dart';
import 'package:aniu/pages/player.dart';
import 'package:aniu/pages/subpages/anime.dart';
import 'package:aniu/pages/subpages/character.dart';
import 'package:aniu/pages/subpages/collections.dart';
import 'package:aniu/pages/subpages/rules.dart';
import 'package:aniu/pages/subpages/settings.dart';
import 'package:aniu/pages/subpages/top_users.dart';
import 'package:aniu/pages/subpages/user_lists.dart';
import 'package:aniu/pages/subpages/user_page.dart';
import 'package:aniu/pages/webview/login.dart';
import 'package:aniu/pages/webview/registration.dart';
import 'package:aniu/pages/webview/reset.dart';
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
  String? id = await fetchRandomRelease();
  toAnimePage(context, id.toString());
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

toCharacterPage(context, String id) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CharacterPage(id: id)
    )
  );
}

toUserPage(context, String id) async {
  return await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserPage(id: id)
    )
  );
}

toRegistrationPage(context) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const RegistrationPage()
      )
  );
}

toResetPage(context) async {
  return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ResetPage()
      )
  );
}

toTelegramPage(context) async {
  if (!await launch('https://t.me/aniuru')) throw 'Не удается запустить страницу с телеграмом';
}

toVkPage(context) async {
  if (!await launch('https://vk.com/anixartru')) throw 'Не удается запустить страницу с вконтакте';
}

toTiktokPage(context) async {
  if (!await launch('https://www.tiktok.com/@aniu.ru?is_copy_url=1&is_from_webapp=v1&lang=ru-RU')) throw 'Не удается запустить страницу с тик током';
}

toDiscordPage(context) async {
  if (!await launch('https://discord.gg/pa3XvuFHMZ')) throw 'Не удается запустить страницу с дискордом';
}