import 'dart:async';

import 'package:aniu/api/check.dart';
import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/pages/home/main.dart';
import 'package:aniu/pages/home/notifications.dart';
import 'package:aniu/pages/home/overview.dart';
import 'package:aniu/pages/home/profile.dart';
import 'package:aniu/pages/lists/anime.dart';
import 'package:aniu/pages/lists/collections.dart';
import 'package:aniu/pages/lists/dramas.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/webview/login.dart';
import 'package:aniu/pages/subpages/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final List<Widget Function(BuildContext context, StreamController streamController)> _widgetOptions = [
    homePage,
    overviewPage,
    notificationsPage,
    profilePage,
  ];
  int indexTest = 1;

  void _onItemTapped(int index) async {
    if(_selectedIndex == 0) _widgetOptions.first = homePage;
    bool userAccessFlag = !await checkUserAccess();
    // print(StoredCookies().toString());
    // print(userAccessFlag); // true - нет доступа, false - есть
    if (index == 3 && userAccessFlag) {
      _toLoginPage(context);
      if (userAccessFlag) return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    StreamController streamController = StreamController();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: const Color(0xff0f1422),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(top: height * 50.0 / templateHeight, left: width * 20 / templateWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Профиль",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(110, 117, 125, 100),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 15 / templateHeight),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          Navigator.pop(context);
                          _onItemTapped(3);
                        }),
                        child: Row(
                          // TODO: Изменять при входе/регистрации
                          children: [
                            const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://aniu.ru/avatars/xno_avatar.png.pagespeed.ic.c6U61IAjHI.webp'
                              ),
                              radius: 18,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 15.0 / templateWidth),
                              child: const Text('Гость', style: titleStyle),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        _widgetOptions.first = homePage;
                      });
                      Navigator.pop(context);
                    },
                    title: const Text(
                      "Главная",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        _widgetOptions.first = animeListPage;
                      });
                      Navigator.pop(context);
                    },
                    title: const Text(
                      "Аниме",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        _widgetOptions.first = dramaListPage;
                      });
                      Navigator.pop(context);
                    },
                    title: const Text(
                      "Дорамы",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        _widgetOptions.first = collectionListPage;
                      });
                      Navigator.pop(context);
                    },
                    title: const Text(
                      "Коллекции",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.pop(context);
                      toRandomPage(context);
                    },
                    title: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/random.svg',
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          " Рандом",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      toDonatePage(context);
                    },
                    title: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/heart.svg',
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          " Кинь донатик",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 10.0 / templateWidth, top: height * 40 / templateHeight),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => toTelegramPage(context),
                      icon: Image.asset('assets/logo/telegram.png'),
                      iconSize: 45,
                    ),
                    IconButton(
                      onPressed: () => toVkPage(context),
                      icon: Image.asset('assets/logo/vk.webp'),
                      iconSize: 45,
                    ),
                    IconButton(
                      onPressed: () => toTiktokPage(context),
                      icon: Image.asset('assets/logo/tiktok.png'),
                      iconSize: 45,
                    ),
                    IconButton(
                      onPressed: () => toDiscordPage(context),
                      icon: Image.asset('assets/logo/discord.png'),
                      iconSize: 45,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 10.0 / templateWidth, right: width * 15 / templateWidth, top: height * 15 / templateHeight),
                child: const Text("Авторы приложения не несут ответственности за его содержимое. © «Анию», 2022", style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0x446c757d)
                ),),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/menu.svg' ,
            color: const Color(0xff6c757d),
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          if (_selectedIndex != 3)
            IconButton(
              onPressed: () { toSearchPage(context); },
              icon: SvgPicture.asset(
                'assets/icons/search.svg' ,
                color: const Color(0xff6c757d),
              ),
            )
          else
            IconButton(
              onPressed: () { _toSettingsPage(context); },
              icon: SvgPicture.asset(
                'assets/icons/settings.svg' ,
                color: const Color(0xff6c757d),
              ),
            )
        ],
        backgroundColor: const Color(0xff0c101b),
      ),
      body: Stack(
        children: [
          Container(
          height: height,
            width: width,
            decoration: const BoxDecoration(
              color: Color(0xff0c101b),
            ),
          ),
          Center(
            child: _widgetOptions.elementAt(_selectedIndex)(context, streamController),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/movie.svg' ,
                color: const Color(0xff6c757d),
              ),
              label: 'Главная',
              backgroundColor: const Color(0xff0c101b),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/overview.svg' ,
                color: const Color(0xff6c757d),
              ),
              label: 'Обзор',
              backgroundColor: const Color(0xff0c101b),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/notice.svg' ,
                color: const Color(0xff6c757d),
              ),
              label: 'Нотисы',
              backgroundColor: const Color(0xff0c101b),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg' ,
                color: const Color(0xff6c757d),
              ),
              label: 'Профиль',
              backgroundColor: const Color(0xff0c101b),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        unselectedItemColor: const Color(0xff6c757d),
        ),
    );
  }

  void _toSettingsPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SettingsPage()
        )
    );
    setState(
      () {
        // print(result);
        if(result != null) _selectedIndex = result;
      }
    );
  }

  void _toLoginPage(BuildContext context) async {

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage()
        )
    );
    setState(
        () {
          // print(result);
          if(result != null) _selectedIndex = result;
        }
    );
  }
}

