import 'package:aniu/api/check.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/pages/home/main.dart';
import 'package:aniu/pages/home/notifications.dart';
import 'package:aniu/pages/home/overview.dart';
import 'package:aniu/pages/home/profile.dart';
import 'package:aniu/pages/lists/anime.dart';
import 'package:aniu/pages/lists/collections.dart';
import 'package:aniu/pages/lists/dramas.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/subpages/rules.dart';
import 'package:aniu/pages/webview/login.dart';
import 'package:aniu/pages/subpages/search.dart';
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
  final List<Widget Function(BuildContext context)> _widgetOptions = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          color: const Color(0xff0f1422),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: const EdgeInsets.only(top: 50.0, left: 20),
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
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          Navigator.pop(context);
                          _onItemTapped(3);
                        }),
                        child: Row(
                          children: const [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://aniu.ru/avatars/xno_avatar.png.pagespeed.ic.c6U61IAjHI.webp'
                              ),
                              radius: 18,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text('Гость', style: titleStyle),
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
                        Container(
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
                        Container(
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
              onPressed: () { _toSearchPage(context); },
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
          height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff0c101b),
            ),
          ),
          Center(
            child: _widgetOptions.elementAt(_selectedIndex)(context),
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

void _toSearchPage(BuildContext context) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const SearchPage()
    )
  );
}

