import 'package:aniu/data/sizes.dart';
import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/requests/role.dart';
import 'package:aniu/pages/router.dart';
import 'package:flutter/material.dart';

Widget swiper(BuildContext context, List items) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return SizedBox(
    height: height * 230 / templateHeight,
    width: width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (  BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            toAnimePage(context, items[index].id);
          },
          child: Padding(
            padding: index == 0 ? EdgeInsets.only(top: height * 10.0 / templateHeight) : EdgeInsets.only(top: height * 10.0 / templateHeight, left: width * 20 / templateWidth),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://aniu.ru/posters/"+items[index].poster+".jpg",
                    fit: BoxFit.cover,
                    width: width * 110 / templateWidth,
                    height: height * 110 * 1.456 / templateHeight,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 8.0 / templateHeight),
                  child: SizedBox(
                    width: width * 110 / templateWidth,
                    height: height * 40 / templateHeight,
                    child: Text(
                      items[index].titleRu,
                      textAlign: TextAlign.start,
                      style: smallStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    ),
  );
}

Widget characterSwiper(BuildContext context, List<Role> roles) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return SizedBox(
    height: height * 225 / templateHeight,
    width: width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: roles.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            toCharacterPage(context, roles[index].character?.id.toString() ?? '');
          },
          child: Padding(
            padding: index == 0 ? const EdgeInsets.only() : EdgeInsets.only(left: width * 20 / templateWidth),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    roles[index].character!.images!.original!,
                    fit: BoxFit.cover,
                    width: width * 105 / templateWidth,
                    height: height * 105 * 1.456 / templateHeight,
                  ),
                ),
                Padding(
                padding: EdgeInsets.only(top: height * 5.0 / templateHeight),
                child: SizedBox(
                  width: width * 105 / templateWidth,
                  height: height * 40 / templateHeight,
                  child: Text(
                    roles[index].character!.nameRu!,
                    textAlign: TextAlign.start,
                    style: cardTextStyle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                )
              ],
            ),
          ),
        );
      }
    ),
  );
}
