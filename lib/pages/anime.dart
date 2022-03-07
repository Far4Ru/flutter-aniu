import 'package:aniu/pages/player.dart';
import 'package:flutter/material.dart';
import '../api/pages.dart';
import '../data/values.dart';
import 'loading_screen.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
            future: fetchRelease(widget.id),
            builder: (BuildContext context, AsyncSnapshot snap){
              if(snap.data == null) {
                return LoadingScreen(context);
              }
              else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        snap.data.titleRu,
                        style: h1Style
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffdc3545)),
                      ),
                      onPressed: () =>_toPlayerPage(context, snap.data.getVideoLink()),
                      child: const Text('Смотреть онлайн', style: titleStyle,),
                    )
                  ],
                );
              }
            }
        ),
        ]
      )
    );
  }
}
void _toPlayerPage(BuildContext context, String link) async {
  bool next = await checkURL(link);
  if(next) {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PlayerPage(link: link)
        )
    );
  }
}