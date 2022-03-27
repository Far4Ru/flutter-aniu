import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/helpers/column_builder.dart';
import 'package:aniu/models/display_data/top_users.dart';
import 'package:aniu/pages/router.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:flutter/material.dart';

class TopUsersPage extends StatefulWidget {
  const TopUsersPage({Key? key}) : super(key: key);


  @override
  State<TopUsersPage> createState() => _TopUsersPageState();
}

class _TopUsersPageState extends State<TopUsersPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = GlobalKey<ScaffoldState>();

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
              FutureBuilder(
                future: fetchTopUsers(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.data == null) {
                    return LoadingScreen(context);
                  } else {
                    List<TopUsersDisplayData> data = snap.data;
                    return ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
                          child: Text('Топ 100', style: h1Style),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
                          child: ColumnBuilder(
                              key: _key,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  color: const Color(0xff090c15),
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.all(1),
                                  child: GestureDetector(
                                    onTap: (){
                                      toUserPage(context, data[index].id);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  data[index].avatar
                                              ),
                                              radius: 23,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 5.0),
                                                    child: Text(data[index].name, style: titleStyle,),
                                                  ),
                                                  Text(data[index].description, style: smallStyle,)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                                      ],
                                    ),
                                  ),
                                );
                              }
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