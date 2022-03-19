import 'package:aniu/models/new.dart';
import 'package:aniu/pages/player.dart';
import 'package:aniu/pages/swiper.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/pages.dart';
import '../data/values.dart';
import 'loading_screen.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _selectedAction;
  final List<String> _actions = [
    "Смотрю",
    "Запланировал",
    "Просмотрено",
    "Отложил",
    "Бросил",
    "Убрать из списка"
  ];

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
          FutureBuilder(
            future: fetchRelease(widget.id),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data == null) {
                return LoadingScreen(context);
              } else {
                return ListView(
                  // shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox.fromSize(
                          size: const Size(9, 300),
                          child: Image.network(
                              "https://aniu.ru/posters/" +
                                  snap.data.poster +
                                  ".jpg",
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 15.0, bottom: 5.0),
                      child: Text(snap.data.titleRu, style: cardTitleStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(
                          snap.data.status.toUpperCase() +
                              " • " +
                              (snap.data.releaseDate ??
                                  snap.data.airedDate.substring(0, 4)) +
                              " • " +
                              snap.data.rating.toUpperCase(),
                          style: cardSubTitleStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28.0, 14.0, 28.0, 0),
                      child: Container(
                        height: 36.0,
                        padding: const EdgeInsets.only(left: 40.0, right: 14.0),
                        decoration: BoxDecoration(
                            color: const Color(0xff66ccff),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          onChanged: (value) {
                            _updateLists(value!);
                            setState(
                              () {
                                _selectedAction = value;
                              },
                            );
                          },
                          value: _selectedAction,
                          hint: const Center(
                            child: Text(
                              'Добавить в список',
                              style: cardButtonStyle,
                            ),
                          ),
                          icon: const Icon(
                            CupertinoIcons.ellipsis,
                            color: Colors.white,
                          ),
                          isExpanded: true,
                          items: _actions
                              .map(
                                (action) => DropdownMenuItem(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      action,
                                      style: cardButtonBlackStyle,
                                    ),
                                  ),
                                  value: action,
                                ),
                              )
                              .toList(),
                          selectedItemBuilder: (BuildContext context) =>
                              _actions
                                  .map(
                                    (action) => Center(
                                      child: Text(
                                        action,
                                        style: cardButtonStyle,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28.0, 10.0, 28.0, 0),
                      child: SizedBox(
                        height: 35.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffcb444a)),
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>(
                              (_) {
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                );
                              },
                            ),
                          ),
                          onPressed: () =>
                              _toPlayerPage(context, snap.data.getVideoLink()),
                          child: const Text(
                            'Смотреть онлайн',
                            style: cardButtonStyle,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 28.0, top: 15.0, bottom: 5.0),
                      child: Text("ОПИСАНИЕ", style: cardTextTitleStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: ExpandableText(
                        //TODO: Решить, что делать с ссылками типа [character=XXXXX]Character[/character], появляются в некоторых текстах
                        snap.data.description,
                        expandText: 'читать полностью',
                        collapseText: '',
                        maxLines: 6,
                        animation: true,
                        collapseOnTextTap: true,
                        expandOnTextTap: true,
                        style: cardTextStyle,
                        linkColor: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 28.0, top: 15.0, bottom: 5.0),
                      child: Text("ВРЕМЯ ПРОСМОТРА", style: cardTextTitleStyle),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Text(
                            snap.data.episodesTotal +
                                " сер. по " +
                                snap.data.duration +
                                " мин.\n" +
                                (int.parse(snap.data.episodesTotal) *
                                        int.parse(snap.data.duration))
                                    .toString() +
                                " мин. всего",
                            style: cardTextStyle)),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 28.0, top: 15.0, bottom: 5.0),
                      child: Text("ОРИГИНАЛЬНОЕ НАЗВАНИЕ",
                          style: cardTextTitleStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                          snap.data.titleOriginal +
                              (snap.data.titleJap
                                          .toLowerCase()
                                          .replaceAll(' ', '') !=
                                      snap.data.titleOriginal
                                          .toLowerCase()
                                          .replaceAll(' ', '')
                                  ? "\n" + snap.data.titleJap
                                  : ""),
                          style: cardTextStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Text("АВТОР", style: cardTextTitleStyle),
                              ),
                              Text(snap.data.author, style: cardTextStyle),
                              const Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 5.0),
                                child:
                                    Text("СТУДИЯ", style: cardTextTitleStyle),
                              ),
                              Text(snap.data.studio, style: cardTextStyle)
                            ],
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 50.0, right: 28.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text("РЕЖИССЁР",
                                            style: cardTextTitleStyle),
                                      ),
                                      Text(snap.data.director,
                                          style: cardTextStyle)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 50.0, right: 28.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 5.0),
                                        child: Text("СТРАНА",
                                            style: cardTextTitleStyle),
                                      ),
                                      Text(snap.data.country,
                                          style: cardTextStyle),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 28.0, top: 15, bottom: 5),
                      child: Text("ЖАНРЫ", style: cardTextTitleStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                          snap.data.genres[0].toUpperCase() +
                              snap.data.genres.substring(1).toLowerCase(),
                          style: cardTextStyle),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 28.0, top: 15.0, bottom: 5.0),
                      child:
                          Text("ОСНОВНЫЕ ПЕРСОНАЖИ", style: cardTextTitleStyle),
                    ),
                    FutureBuilder(
                        future: fetchReleaseRoles(widget.id),
                        builder: (BuildContext context, AsyncSnapshot<List<Role>> snap) {
                          // if (snap.data == null) {
                          //   TODO?: Empty characters cards loading
                          // } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 28.0, top: 15.0, bottom: 20.0),
                              child: characterSwiper(context, snap.data),
                            );
                          }
                        // },
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

void _toPlayerPage(BuildContext context, String link) async {
  bool next = true; // await checkURL(link);
  if (next) {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => PlayerPage(link: link)));
  }
}

void _updateLists(String list) async {}