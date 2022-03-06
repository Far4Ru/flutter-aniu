import 'package:flutter/material.dart';
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
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  static final List<Widget Function(BuildContext context)> _widgetOptions = [
    homePage,
    overviewPage,
    notificationsPage,
    profilePage,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchNew22();
    return Scaffold(
      key: _scaffoldKey,
      drawer: leftPanel(context),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.dehaze),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: const [
          Icon(Icons.search)
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

}
