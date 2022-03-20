import 'package:flutter/material.dart';

Widget leftPanel(BuildContext context) {
  return Drawer(
    child: Container(
      color: const Color(0xff0f1422),
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
          // TODO: - Картинка профиля и никнейм (Гость)
          const SizedBox(
            height: 70,
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
                    Padding(
                      padding: EdgeInsets.only(left: 43.0),
                      child: Text(
                        "Аниме",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 43.0),
                      child: Text(
                        "Дорамы",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 43.0),
                      child: Text(
                        "Коллекции",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 43.0),
                      child: Text(
                        "Рандом",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 43.0),
                      child: Text(
                        "Донат",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
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
  );
}







