import 'package:aniu/objectbox.g.dart';
import 'package:aniu/pages/login.dart';
import 'package:aniu/pages/search.dart';
import 'package:aniu/pages/settings.dart';
import 'package:flutter/material.dart';
import 'models/cookies.dart';
import 'pages/left_panel.dart';
import 'pages/notifications.dart';
import 'pages/home.dart';
import 'pages/overview.dart';
import 'pages/profile.dart';
import 'api/pages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static final List<Widget Function(BuildContext context)> _widgetOptions = [
    homePage,
    overviewPage,
    notificationsPage,
    profilePage,
  ];

  void _onItemTapped(int index) async {
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
      drawer: leftPanel(context),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.dehaze),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          if (_selectedIndex != 3)
            IconButton(
              onPressed: () { _toSearchPage(context); },
              icon: const Icon(Icons.search)
            )
          else
            IconButton(
              onPressed: () { _toSettingsPage(context); },
              icon: const Icon(Icons.filter_vintage)
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_outlined),
              label: 'Главная',
              backgroundColor: Color(0xff0c101b),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration),
              label: 'Обзор',
              backgroundColor: Color(0xff0c101b),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Нотисы',
              backgroundColor: Color(0xff0c101b),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Профиль',
              backgroundColor: Color(0xff0c101b),
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

