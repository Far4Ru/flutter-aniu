import 'package:flutter/material.dart';
import '../data/values.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aniu/models/new.dart';
import 'anime.dart';

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
    var searchResult = await http.get(Uri.parse("https://aniu.ru/api/v1/release.list.popular"));
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
              if (animeList.isEmpty)
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
              ) else
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Результат',
                          style: h1Style,
                        ),
                        Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: animeList.length ~/3,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [if(3*index<animeList.length) GestureDetector(
                                    onTap: (){
                                      _toAnimePage(context, animeList[3*index].id);
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://aniu.ru/posters/"+animeList[3*index].poster+".jpg",
                                            fit: BoxFit.cover,
                                            height: 110,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          child: Text(
                                              animeList[3*index].titleRu,
                                              style: smallStyle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        )
                                      ],
                                    ),
                                  ),if(3*index+1<animeList.length) GestureDetector(
                                    onTap: (){
                                      _toAnimePage(context, animeList[3*index+1].id);
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://aniu.ru/posters/"+animeList[3*index+1].poster+".jpg",
                                            fit: BoxFit.cover,
                                            height: 110,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          child: Text(
                                              animeList[3*index+1].titleRu,
                                              style: smallStyle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        )
                                      ],
                                    ),
                                  ),if(3*index+2<animeList.length) GestureDetector(
                                    onTap: (){
                                      _toAnimePage(context, animeList[3*index+2].id);
                                    },
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://aniu.ru/posters/"+animeList[3*index+2].poster+".jpg",
                                            fit: BoxFit.cover,
                                            height: 110,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 40,
                                          child: Text(
                                              animeList[3*index+2].titleRu,
                                              style: smallStyle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        )
                                      ],
                                    ),
                                  ),]
                                );
                              }
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

void _toAnimePage(BuildContext context, String id) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AnimePage(id: id)
      )
  );
}