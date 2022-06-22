import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/models/display_data/collection.dart';
import 'package:aniu/pages/widgets/collectionCard.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({Key? key}) : super(key: key);

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final _key = GlobalKey<ScaffoldState>();
    List<CollectionDisplayData> data;

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
          //const Text('Коллекции', style: h1Style),
          FutureBuilder(
              future: fetchCollectionPage(0),
              builder: (BuildContext context, AsyncSnapshot snap){
                if(snap.data == null) {
                  return LoadingScreen(context);
                }
                else {
                  if(snap.data is! List<CollectionDisplayData>) return LoadingScreen(context);
                  data = snap.data;
                  return ListView(
                    // shrinkWrap: true,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
                            child: Text(
                                'Коллекции',
                                style: h1Style
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ColumnBuilder(
                              // scrollDirection: Axis.vertical,
                              itemCount: data.length < 2 ? data.length : data.length ~/ 2 + 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                    children: [
                                      if (2 * index < data.length) collectionCard(context, data[2 * index]),
                                      if (2 * index + 1 < data.length) collectionCard(context, data[2 * index + 1]),
                                    ]
                                );
                              }, key: _key,
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }
              }
          )
        ]
      )
    );
  }
}