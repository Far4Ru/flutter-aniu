import 'package:aniu/data/values.dart';
import 'package:flutter/material.dart';

class QuickActions{
  final String title;
  final String description;
  final Function toPage;
  final String image;

  QuickActions(this.title, this.description, this.toPage, this.image);

}

Widget actionsSwiper(BuildContext context) {
  List<QuickActions> items = [
    QuickActions('Помочь сайту', 'Накинь косарик пожалуйста', toDonatePage, ''),
    QuickActions('Топ', 'Пользователей сайта', toTopUsersPage, ''),
    QuickActions('Рандом', 'Случайное аниме', toRandomPage, ''),
    QuickActions('Избранное', 'Только самое ценное', toFavouritesPage, ''),
    QuickActions('Коллекции', 'От Anixart', toCollectionsPage, ''),
    QuickActions('Правила сайта', 'Много важных букв', toRulesPage, ''),
  ];
  return Container(
    height: 220,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length ~/ 2,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              _quickActionCard(context, items[2 * index]),
              _quickActionCard(context, items[2 * index + 1])
            ]
          );
        }
    ),
  );
}

Widget _quickActionCard(BuildContext context, QuickActions quickActionsItem) {
  return GestureDetector(
    onTap: (){
      quickActionsItem.toPage();
    },
    child: Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(quickActionsItem.title, style: titleStyle,),
          Text(quickActionsItem.description, style: smallStyle,),
        ],
      ),
      decoration: BoxDecoration(
        color: const Color(0xff0f1422),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

toRandomPage() {
  // TODO: - https://aniu.ru/anime/random
}
toCollectionsPage(){
  // TODO: - collections.dart
}
toFavouritesPage(){
  // TODO: - favourites.dart
}
toRulesPage(){
  // TODO: - rules.dart
}
toDonatePage(){
  // TODO: - https://my.qiwi.com/Aleksei-AIGtMGn6g6?noCache=true
}
toTopUsersPage(){
  // TODO: - top_users.dart
}