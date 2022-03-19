import 'package:aniu/home.dart';
import 'package:flutter/material.dart';
import 'helpers/store.dart';
import 'pages/subpages/anime.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(const AniuApp());
}

class AniuApp extends StatelessWidget {
  const AniuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aniu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/anime': (context) => const AnimePage(id: "1"),
        '/dorams': (context) => const AnimePage(id: "1"),
        '/collections': (context) => const AnimePage(id: "1"),
        '/random': (context) => const AnimePage(id: "1"),
        '/donat': (context) => const AnimePage(id: "1"),
      },
    );
  }
}

