import 'package:aniu/data/text_styles.dart';
import 'package:aniu/models/objectbox/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
              ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
                    child: Text('Настройки', style: h1Style),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0, left: 19.0, right: 19.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top:15, bottom: 15),
                          child: Text('Профиль', style: h3Style),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  // TODO: Изменять при входе/регистрации
                                children: [
                                    const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        'https://aniu.ru/avatars/xno_avatar.png.pagespeed.ic.c6U61IAjHI.webp'
                                      ),
                                      radius: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5.0),
                                            child: Text('Гость', style: titleStyle,),
                                          ),
                                          Text('Guest@mail.ru', style: smallStyle,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:15, bottom: 15),
                          child: Text('Аккаунт', style: h3Style),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/profile.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child:
                                          Text('Управление аккаунтом', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/password.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Пароль и безопасность', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/control.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Управление приложением', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/avatar.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Аватар и фон', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/rating.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Рейтинг', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/tools.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Инструменты даббера', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:15, bottom: 15),
                          child: Text('Контент и действия', style: h3Style),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/history.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('История просмотров', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/confidentiality.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Конфиденциальность', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: SvgPicture.asset(
                                        'assets/icons/family.svg' ,
                                        color: const Color(0xff6c757d),
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Семейные настройки', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:15, bottom: 15),
                          child: Text('О приложении', style: h3Style),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // CircleAvatar(
                                    //   backgroundImage: NetworkImage(
                                    //       data[index].avatar
                                    //   ),
                                    //   radius: 23,
                                    // ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const [
                                            Text('Что нового?', style: smallStyle,),
                                            Text('Показать историю версий', style: smallStyle,),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('Сообщить об ошибке', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff090c15),
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap: (){
                              // toUserPage(context, data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child:
                                        Text('О нас', style: smallStyle,)
                                    ),
                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.grey,)
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top:15, bottom: 15),
                          child: Text('Приступая к использованию Aniu, вы соглашаетесь с нашей Политикой конфиденциальности и Условиями обслуживания,'
                              ' а также принимаете тот факт, что автор сайта не несёт ответственности за его содержимое.', style: smallStyle,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffdc3545)),
                              ),
                              onPressed: () {
                                StoredUser('').logout();
                                Navigator.pop(context, 0);
                              },
                              child: const Text('Выйти', style: titleStyle,),
                            ),
                          ),
                        )
                      ]
                    ),
                  )
                ],
              )
            ]
        )
    );
  }
}