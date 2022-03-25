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
                        Text('Топ 100', style: h1Style),
                        ColumnBuilder(
                            key: _key,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                onTap: (){
                                  toUserPage(context, data[index].id);
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          data[index].avatar
                                      ),
                                      radius: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(data[index].name, style: titleStyle,),
                                        Text(data[index].description, style: smallStyle,)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
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