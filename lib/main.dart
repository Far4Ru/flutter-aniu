import 'package:aniu/pages/notifications.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        '/anime': (context) => const MyHomePage(title: ''),
        '/dorams': (context) => const MyHomePage(title: ''),
        '/collections': (context) => const MyHomePage(title: ''),
        '/random': (context) => const MyHomePage(title: ''),
        '/donat': (context) => const MyHomePage(title: '')
      },
    );
  }
}

