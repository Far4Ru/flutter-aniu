import 'package:aniu/api/fetch.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/display_data/character.dart';
import 'package:aniu/pages/widgets/loading_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
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
            future: fetchCharacter(widget.id),
            builder: (BuildContext context, AsyncSnapshot snap) {
              if (snap.data == null) {
                return LoadingScreen(context);
              } else {
                CharacterDisplayData data = snap.data;
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 110.0, right: 110.0, top: 28.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: SizedBox.fromSize(
                          size: const Size(9, 300),
                          child: Image.network(
                              data.image,
                              fit: BoxFit.fitHeight
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 15.0, bottom: 5.0),
                      child: Text(
                        data.title,
                        style: cardTitleStyle
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(
                        data.alternativeTitle,
                        style: cardSubTitleStyle
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 28.0, bottom: 28),
                      child: ExpandableText(
                        data.description.replaceAll(RegExp(r'\<[\x00-\x7F]+\>'), ""),
                        expandText: 'читать полностью',
                        collapseText: '',
                        maxLines: 6,
                        animation: true,
                        collapseOnTextTap: true,
                        expandOnTextTap: true,
                        style: cardTextStyle,
                        linkColor: Colors.grey,
                      ),
                    ),
                  ],
                );
              }
            }
          )
        ],
      )
    );
  }
}