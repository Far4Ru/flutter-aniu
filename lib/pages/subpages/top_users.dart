import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/sizes.dart';
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
                height: height,
                width: width,
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
                        Padding(
                          padding: EdgeInsets.only(top: height * 14.0 / templateHeight, left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
                          child: const Text('Топ 100', style: h1Style),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: height * 14.0 / templateHeight, left: width * 19.0 / templateWidth, right: width * 19.0 / templateWidth),
                          child: ColumnBuilder(
                              key: _key,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index){
                                return Container(
                                  color: const Color(0xff090c15),
                                  padding: EdgeInsets.all(height * 20 / templateHeight),
                                  margin: EdgeInsets.all(height * 1 / templateHeight),
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
                                              padding: EdgeInsets.only(left: width * 10.0 / templateWidth),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(bottom: height * 5.0 / templateHeight),
                                                    child: Text(data[index].name, style: titleStyle,),
                                                  ),
                                                  SizedBox(
                                                    height: height * 40 / templateHeight,
                                                    width: width * 220 /  templateWidth,
                                                    child: Text(data[index].description, style: smallStyle,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis),
                                                  )
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