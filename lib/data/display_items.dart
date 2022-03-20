import 'package:aniu/models/display_data/quick_actions.dart';
import 'package:aniu/pages/router.dart';

List<QuickActionsDisplayData> displayQuickActions = [
  QuickActionsDisplayData('Помочь сайту', 'Накинь касарик пожалуйста', toDonatePage, 'balloon'),
  QuickActionsDisplayData('Топ', 'Пользователей сайта', toTopUsersPage, 'histogram'),
  QuickActionsDisplayData('Рандом', 'Случайное аниме', toRandomPage, 'dice'),
  QuickActionsDisplayData('Избранное', 'Только самое ценное', toFavouritesPage, 'heart'),
  QuickActionsDisplayData('Коллекции', 'От Anixart', toCollectionsPage, 'slides'),
  QuickActionsDisplayData('Правила сайта', 'Много важных букв', toRulesPage, 'routes'),
];
List<QuickActionsDisplayData> displayMyLists = [
  QuickActionsDisplayData('Смотрю', 'Пожалуй, самое важное место', toDonatePage, '1'),
  QuickActionsDisplayData('Просмотрено', 'Похвастайся перед друзьями', toTopUsersPage, '2'),
  QuickActionsDisplayData('Запланировано', 'Не забудь, это важно!', toRandomPage, '3'),
  QuickActionsDisplayData('Отложено', 'Возможно, когда-нибудь я вернусь к этому', toFavouritesPage, '4'),
];