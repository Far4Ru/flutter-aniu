import 'package:flutter/material.dart';
import 'helpers/store.dart';
import 'home.dart';
import 'pages/anime.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

