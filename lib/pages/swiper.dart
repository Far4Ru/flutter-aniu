import 'package:aniu/data/values.dart';
import 'package:flutter/material.dart';
import 'anime.dart';

Widget swiper(BuildContext context, List? items) {
  return Container(
    height: 220,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (items ?? []).length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              _toAnimePage(context, (items ?? [])[index].id);
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://aniu.ru/posters/"+(items ?? [])[index].poster+".jpg",
                    fit: BoxFit.cover,
                    height: 180,
                  ),
                ),
                Container(
                  width: 150,
                  height: 40,
                  child: Text(
                      (items ?? [])[index].titleRu,
                      style: smallStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),
                )
              ],
            ),
          );
        }
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