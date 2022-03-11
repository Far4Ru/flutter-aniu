import 'package:flutter/material.dart';
import '../data/values.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
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
              Container(
                margin: EdgeInsets.only(top: 25),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                height: 35.0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 35,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Поиск',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15)
                      ),
                      color: Colors.white
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Начать поиск',
                        style: h1Style,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: const Text(
                          'Поиск по названию фильма, сериала, персонажа, режисера, производственной компании, описанию и тегах.',
                          style: smallStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]
        )
    );
  }
}
Widget searchPage(BuildContext context) {
  return Center(
    child: Column(
      children: const [
        Text(
          'Начать поиск',
          style: h1Style,
        ),
        Text(
          'Поиск по названию фильма, сериала, персонажа, режисера, производственной компании, описанию и тегах.',
          style: smallStyle,
        ),
      ],
    ),
  );
}