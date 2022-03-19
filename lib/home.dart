import 'package:aniu/api/check.dart';
import 'package:aniu/pages/home/main.dart';
import 'package:aniu/pages/webview/login.dart';
import 'package:aniu/pages/subpages/search.dart';
import 'package:aniu/pages/subpages/settings.dart';
import 'package:flutter/material.dart';
import 'pages/widgets/left_panel.dart';
import 'pages/home/notifications.dart';
import 'pages/home/overview.dart';
import 'pages/home/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

