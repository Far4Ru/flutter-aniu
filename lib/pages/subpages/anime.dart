import 'package:aniu/api/fetch.dart';
import 'package:aniu/api/save.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:aniu/pages/widgets/swiper.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

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
    "Добавить в список",
    "Смотрю",
    "Запланировал",
    "Просмотрено",
    "Отложил",
    "Бросил",
    "Убрать из списка"
  ];
  final _swiperController = SwiperController();

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
                var list = snap.data['list'];
                if (list.toString() != 'false') {
                  if(_actions[int.parse(list['id'])] == list['name']) _selectedAction = _actions[int.parse(list['id'])];
                }
                var links = snap.data['links'];
                var swipeList = [];
                var data = snap.data['release'];
                swipeList.add(data);
                swipeList.addAll(links['related']);
                return ListView(
                  // shrinkWrap: true,
                  children: [
                    if (data.poster != null) if (swipeList.length <= 1) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox.fromSize(
                          size: const Size(9, 300),
                          child: Image.network(
                              "https://aniu.ru/posters/" + (data.poster ?? '') + ".jpg",
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                    ),
                    if (swipeList.length > 1) SizedBox(
                      height: 400,
                      child: Align(
                        alignment: Alignment.center,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image.network(
                                "https://aniu.ru/posters/" + swipeList[index].poster + ".jpg",
                                fit: BoxFit.fitHeight,
                              ),
                            );
                          },
                          itemHeight: 300,
                          loop: false,
                          onIndexChanged: (int index) => print(index),
                          itemCount: swipeList.length,
                          itemWidth: 200,
                          layout: SwiperLayout.STACK,
                          pagination: const SwiperPagination(
                            margin: EdgeInsets.only(top: 30)
                          ),
                          controller: _swiperController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 15.0, bottom: 5.0),
                      child: Text(data.titleRu ?? '', style: cardTitleStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              (data.status ?? '').toUpperCase() +
                                  " • " +
                                  (data.releaseDate
                                      ?? (data.airedDate ?? '    ').substring(0, 4)) +
                                  " • " +
                                  (data.rating ?? '').toUpperCase(),
                              style: cardSubTitleStyle),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Row(children: [
                              Text("⭐ "+
                                  (double.parse(
                                      data.kinopoiskRating
                                      ?? data.imdbRating
                                      ?? data.shikimoriRating
                                      ?? "11")
                                    <= 10
                                    ? (data.kinopoiskRating
                                      ?? data.imdbRating
                                      ?? data.shikimoriRating ?? '')
                                    : "-"),
                                  style: cardSubTitleStyle),
                            ]),
                          )
                        ],
                      ),
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
                          onChanged: (value) async {
                            int index = await _updateLists(
                              data.id,
                              _actions.indexWhere((element) => element == value)
                            );
                            setState(
                              () {
                                _selectedAction = _actions[index];
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
                              toPlayerPage(context, data.getVideoLink()),
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
                        (data.description ?? '').replaceAll(RegExp(r'(\[\w+=\d+\]|\[\/\w+\])'), ""),
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
                            (data.episodesTotal ?? '') +
                                " сер. по " +
                                (data.duration ?? '') +
                                " мин.\n" +
                                (int.parse(data.episodesTotal ?? '') *
                                        int.parse((data.duration ?? '')))
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
                        (data.titleOriginal ?? '')
                        + (
                          (data.titleJap ?? '')
                            .toLowerCase()
                            .replaceAll(' ', '')
                              != (data.titleOriginal ?? '')
                                .toLowerCase()
                                .replaceAll(' ', '')
                              ? "\n" + (data.titleJap ?? '')
                              : ""
                        ),
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
                              Text(data.author ?? '', style: cardTextStyle),
                              const Padding(
                                padding:
                                    EdgeInsets.only(top: 15.0, bottom: 5.0),
                                child:
                                    Text("СТУДИЯ", style: cardTextTitleStyle),
                              ),
                              Text(data.studio ?? '', style: cardTextStyle)
                            ],
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50.0, right: 28.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Text("РЕЖИССЁР",
                                            style: cardTextTitleStyle),
                                      ),
                                      Text(data.director ?? '',
                                          style: cardTextStyle)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 50.0, right: 28.0),
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
                                      Text((data.country ?? ''), style: cardTextStyle),
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
                          (data.genres ?? '')[0].toUpperCase() +
                              (data.genres ?? '').substring(1).toLowerCase(),
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
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        var data = snap.data;
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, top: 15.0, bottom: 20.0),
                          child: characterSwiper(context, data ?? []),
                        );
                      },
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

Future<int> _updateLists(id, int type) async {
  if (type > 4) type = 0;
  await changeStatus(id, type);
  return type;
}
