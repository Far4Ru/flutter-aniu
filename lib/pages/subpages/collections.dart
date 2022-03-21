import 'package:aniu/data/text_styles.dart';
import 'package:flutter/material.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
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
          /// TODO: - Страница коллекций
          /// https://aniu.ru/collection
          /// 1. Заголовок "Коллекции"
          /// 2. Подзаголовок "от Anixart"
          /// 3. ListView, Stack, ClipRRect, Image.network, Text
          /// 4. Запрос в ~/api/fetch.dart - Future fetchCollections()
          /// 5. Класс в ~/models/display_data/collections.dart - CollectionsDisplayData
          /// 6. Отпарсить в ~/api/parse.dart - CollectionsDisplayData parseCollections(body)
          /// 7. Вывести в ListView
          const Text('Коллекции', style: h1Style)
        ]
      )
    );
  }
}