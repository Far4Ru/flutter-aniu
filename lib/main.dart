import 'package:aniu/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helpers/store.dart';

late ObjectBox objectbox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff0c101b),
      statusBarColor: Color(0xff0c101b)
  ));
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
    );
  }
}
