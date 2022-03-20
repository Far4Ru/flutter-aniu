import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/requests/release.dart';
import 'package:aniu/pages/router.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();
  List animeList = [];

  void fetchSearch(String input) async {
    if (input.isEmpty) {
      setState(() {
        animeList = [];
      });
      return;
    }
    /**
     * TODO: - поисковой запрос
     * по хрефу вытаскивать через регулярное вырожение вытаскивать id и в начале было аниме
     * убрать дубликаты, получаем список id, создать список релизов( перебрать по списку id пока for не закончим
     * запросы (http) в цикле чтобы перебрать)
     */
    // var searchResult = await http.get(Uri.parse("https://aniu.ru/search/"+ input));
    // print(searchResult.body);
    // var doc = parse(searchResult.body);
    // doc.getElementsByTagName('a').map((e) => e.attributes.forEach((key, value) {print(key);}));
    //var idpis = doc.getElementsByClassName("poster").map((e) => e.parent!.innerHtml);// .attributes["data-release"]);
    //idpis.forEach((element) {print(element);});
    // return;
    final searchResult = await http.get(Uri.parse('https://aniu.ru/api/v1/release.list.popular'));
    var result = jsonDecode(searchResult.body).map((jsonItem) => Release.fromJson(jsonItem)).toList();
    setState(() {
      animeList = result;
    });
  }

  void onTextFieldSubmitted(String input) {
    fetchSearch(input);
  }

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
          Column(
            children: [
              Container(
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
                    onSubmitted: (String input) {
                      onTextFieldSubmitted(input);
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
              if (animeList.isEmpty) Container(
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
              else Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 558,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: animeList.length ~/3,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          if (3 * index < animeList.length) searchCard(context, animeList, 3 * index),
                          if (3 * index + 1 < animeList.length) searchCard(context, animeList, 3 * index + 1),
                          if (3 * index + 2 < animeList.length) searchCard(context, animeList, 3 * index + 2),
                        ]
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        ]
      )
    );
  }
}

Widget searchCard(BuildContext context, animeList, index) {
  return Padding(
    padding: const EdgeInsets.only(left: 13.0, top: 8.0),
    child: GestureDetector(
      onTap: (){
        toAnimePage(context, animeList[index].id);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://aniu.ru/posters/"+animeList[index].poster+".jpg",
              fit: BoxFit.cover,
              width: 120,
              height: 120 * 1.456,
            ),
          ),
          Container(
            width: 120,
            height: 40,
            child: Text(
                animeList[index].titleRu,
                style: smallStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis
            ),
          )
        ],
      ),
    ),
  );
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