import 'package:aniu/data/text_styles.dart';
import 'package:flutter/material.dart';

class TopUsersPage extends StatefulWidget {
  const TopUsersPage({Key? key}) : super(key: key);


  @override
  State<TopUsersPage> createState() => _TopUsersPageState();
}

class _TopUsersPageState extends State<TopUsersPage> {
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
              /// TODO: - Страница топа пользователей
              /// https://aniu.ru/user
              /// 1. Заголовок Топ 100
              /// 2. ListView: аватар, имя, рейтинг, комментариев, иконка стрелки вправо
              /// 3. Запрос в ~/api/fetch.dart - Future fetchTopUsers()
              /// 4. Создать класс в ~/models/display_data/top_users.dart - TopUsersDisplayData
              ///  - String avatar
              ///  - String name
              ///  - String id
              ///  - String rating
              ///  - String comments
              /// 5. Отпарсить в ~/api/parse.dart - TopUsersDisplayData parseTopUsers(body)
              /// 6. Вывести в ListView
              const Text('Топ пользователей', style: h1Style)
            ]
        )
    );
  }
}