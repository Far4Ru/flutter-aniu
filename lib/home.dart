import 'package:aniu/api/check.dart';
import 'package:aniu/pages/home/main.dart';
import 'package:aniu/pages/home/notifications.dart';
import 'package:aniu/pages/home/overview.dart';
import 'package:aniu/pages/home/profile.dart';
import 'package:aniu/pages/webview/login.dart';
import 'package:aniu/pages/subpages/search.dart';
import 'package:aniu/pages/subpages/settings.dart';
import 'package:aniu/pages/widgets/left_panel.dart';
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

