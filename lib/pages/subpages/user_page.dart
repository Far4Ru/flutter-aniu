import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/user.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
              FutureBuilder(
                  future: fetchUser(widget.id),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.data == null) {
                      return LoadingScreen(context);
                    } else {
                      UserDisplayData user = snap.data;
                      return Column(
                        children: [
                          Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Column(
                                  children: [
                                    if (user.poster.isNotEmpty) ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        user.poster,
                                        fit: BoxFit.cover,
                                        width: 390,
                                        height: 390 * 0.28,
                                        // color: const Color(0xff6c757d), //set the desired color
                                        // colorBlendMode: BlendMode.darken,
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: Row(
                                    children: [
                                      if (user.avatar.isNotEmpty) Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              user.avatar
                                          ),
                                          radius: 25,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(user.name,style: h1Style),
                                            Row(
                                              children: [
                                                Text(user.tag,style: smallStyle),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15.0),
                                                  child: Text('ID: ' + user.id, style: smallStyle),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                          ),
                          Container(
                            height: 80,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: user.stats.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 23.0,top: 20.0),
                                    child: Column(
                                      children: [
                                        Text(user.stats.keys.elementAt(index),style: titleStyle,),
                                        Text(user.stats.values.elementAt(index).toString(), style: titleStyle,)
                                      ],
                                    ),
                                  );
                                }
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffdc3545)),
                              ),
                              onPressed: () {
                              },
                              child: const Text('Добавить в друзья', style: titleStyle,),
                            ),
                          )
                        ],
                      );
                    }
                  }
              )
            ]
        )
    );
  }
}