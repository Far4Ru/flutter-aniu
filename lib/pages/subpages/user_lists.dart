import 'dart:async';

import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/models/display_data/release.dart';
import 'package:aniu/pages/widgets/animeCard.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

class UserListsPage extends StatefulWidget {
  const UserListsPage({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  State<UserListsPage> createState() => _UserListsPageState();
}

class _UserListsPageState extends State<UserListsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedList = "";
  String newSelectedList = "";
  double width = 0;
  double height = 0;
  final Map<String, String> _selectedList = {
    "watching": "Смотрю",
    "plan": "Запланировано",
    "completed": "Просмотрено",
    "hold": "Отложил",
    "dropped": "Брошено",
    "favorite": "Избранное",
  };
  StreamController streamController = StreamController();

  @override
  void initState() {
    selectedList = widget.type;
    newSelectedList = selectedList;
    load();
    super.initState();
  }

  load() async {
    streamController.add(await fetchUserList(newSelectedList));
  }

  @override
  void didUpdateWidget(UserListsPage oldWidget) {
    if (selectedList != newSelectedList) {
      load();
    }
    selectedList = newSelectedList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  _changeRelease(type) {
    setState(
      () {
        newSelectedList = type;
      },
    );
    didUpdateWidget(widget);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    final _key = GlobalKey<ScaffoldState>();

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
          StreamBuilder(
            stream: streamController.stream,
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data == null) {
                return LoadingScreen(context);
              } else {
                if (snap.data is! List<ReleaseDisplayData>) {
                  return LoadingScreen(context);
                }
                return Stack(
                  // shrinkWrap: true,
                  children: [
                    ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Списки",
                                style: listStyle,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                _selectedList[selectedList].toString(),
                                style: listStyle,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffcb444a)),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (_) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () => {
                                              _changeRelease("watching"),
                                            },
                                            child: const Text(
                                              'Смотрю',
                                              style: cardButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffcb444a)),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (_) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () => {
                                              _changeRelease("plan"),
                                            },
                                            child: const Text(
                                              'Запланировано',
                                              style: cardButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffcb444a)),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (_) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () => {
                                              _changeRelease("completed"),
                                            },
                                            child: const Text(
                                              'Просмотрено',
                                              style: cardButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffcb444a)),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (_) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () => {
                                              _changeRelease("hold"),
                                            },
                                            child: const Text(
                                              'Отложено',
                                              style: cardButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffcb444a)),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (_) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () => {
                                              _changeRelease("dropped"),
                                            },
                                            child: const Text(
                                              'Брошено',
                                              style: cardButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4.0, right: 4.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color(0xffcb444a)),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (_) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () => {
                                              _changeRelease("favorite"),
                                            },
                                            child: const Text(
                                              'Избранное',
                                              style: cardButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: ColumnBuilder(
                                itemCount: snap.data.length < 3 ? snap.data.length : snap.data.length ~/ 3 + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      if (3 * index < snap.data.length)
                                        animeCard(
                                            context, snap.data[3 * index]),
                                      if (3 * index + 1 < snap.data.length)
                                        animeCard(
                                            context, snap.data[3 * index + 1]),
                                      if (3 * index + 2 < snap.data.length)
                                        animeCard(
                                            context, snap.data[3 * index + 2]),
                                    ],
                                  );
                                },
                                key: _key,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
