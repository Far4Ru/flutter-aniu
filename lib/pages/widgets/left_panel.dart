import 'package:aniu/data/text_styles.dart';
import 'package:flutter/material.dart';

Widget leftPanel(BuildContext context) {
  return Drawer(
    child: Container(
      color: const Color(0xff0f1422),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 40.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Профиль",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(110, 117, 125, 100),
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://aniu.ru/avatars/xno_avatar.png.pagespeed.ic.c6U61IAjHI.webp'
                    ),
                    radius: 18,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text('Гость', style: titleStyle),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // TODO: - Переходы на страницы
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/anime');
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Аниме",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dorams');
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Дорамы",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/collections');
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Коллекции",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Рандом",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/donat');
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Донат",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    ),
  );
}







