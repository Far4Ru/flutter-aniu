import 'package:aniu/data/text_styles.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
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
              /// TODO: - Страница правил
              /// https://aniu.ru/info/rules
              /// 1. Заголовок "Правила сайта"
              /// 2. ListView
              /// 3. Сделать запрос в ~/api/fetch.dart - Future fetchRules()
              /// 4. Создать класс с необходимыми полями в ~/models/display_data/rules.dart - RulesDisplayData
              /// 5. Отпарсить в ~/api/parse.dart - RulesDisplayData parseRules(body)
              /// 6. Вывести в ListView
              const Text('Правила', style: h1Style)
            ]
        )
    );
  }
}