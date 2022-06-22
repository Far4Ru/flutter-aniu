import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/pages/widgets/animeCard.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key, required this.href}) : super(key: key);
  final String href;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<ScaffoldState>();
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: const Color(0xff0c101b),
        ),
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff0c101b),
            ),
          ),
          FutureBuilder(
              future: fetchCollection(widget.href),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (snap.data == null) {
                  return LoadingScreen(context);
                } else {
                  var pageData = snap.data;
                  var title = pageData['title'];
                  var description = pageData['description'];
                  var data = pageData['list'];
                  return ListView(
                    // shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 19.0, right: 19.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 14.0,
                              ),
                              child: Text(title, style: h1Style),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 19.0, right: 19.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 14.0,
                              ),
                              child: Text(description, style: smallStyle),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ColumnBuilder(
                          // scrollDirection: Axis.vertical,
                          itemCount: data.length < 3 ? data.length : data.length ~/ 3 + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(children: [
                              if (3 * index < data.length)
                                animeCard(context, data[3 * index]),
                              if (3 * index + 1 < data.length)
                                animeCard(context, data[3 * index + 1]),
                              if (3 * index + 2 < data.length)
                                animeCard(context, data[3 * index + 2]),
                            ]);
                          },
                          key: _key,
                        ),
                      )
                    ],
                  );
                }
              })
        ]));
  }
}
