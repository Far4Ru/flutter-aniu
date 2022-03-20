import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/requests/role.dart';
import 'package:aniu/pages/router.dart';
import 'package:flutter/material.dart';

Widget swiper(BuildContext context, List items) {
  return Container(
    height: 230,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (  BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            toAnimePage(context, items[index].id);
          },
          child: Padding(
            padding: index == 0 ? const EdgeInsets.only(top: 10.0) : const EdgeInsets.only(top: 10.0, left: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://aniu.ru/posters/"+items[index].poster+".jpg",
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110 * 1.456,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: 110,
                    height: 40,
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
  return SizedBox(
    height: 225,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: roles.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            // TODO?: _toCharacterPage(context, (items ?? [])[index].character.url);
          },
          child: Padding(
            padding: index == 0 ? const EdgeInsets.only() : const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    roles[index].character!.images!.original!,
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110 * 1.456,
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  width: 110,
                  height: 40,
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
