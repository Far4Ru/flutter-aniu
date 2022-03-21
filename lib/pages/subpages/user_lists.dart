import 'package:aniu/data/text_styles.dart';
import 'package:flutter/material.dart';

class UserListsPage extends StatefulWidget {
  const UserListsPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<UserListsPage> createState() => _UserListsPageState();
}

class _UserListsPageState extends State<UserListsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color(0xff0c101b),
        ),
        body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff0c101b),
                ),
              ),
              /// TODO: - Страница списков пользователя
              /// https://aniu.ru/user/?list=
              /// [watching, plan, completed, hold, dropped, favorite]
              /// 1. Заголовок "Списки"
              /// 2. Подзаголовок "Мои списки"
              /// 3. 6 кнопок по 3 в ряду: Смотрю, Запланировано, Просмотрено, Отложено, Брошено, Избранное
              /// 4. Подзаголовок "Содержимое"
              /// 5. ListView по 3 элемента в ряду как в search.dart
              /// 6. Запрос в ~/api/fetch.dart - Future fetchUserList(String type)
              /// 7. Отпарсить идентификаторы в ~/api/parse.dart - List<Release> parseUserList(body)
              /// 8. Вывести в ListView
              Text('Список пользователя ' + widget.id, style: h1Style)
            ]
        )
    );
  }
}