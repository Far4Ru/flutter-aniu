import 'package:aniu/models/display_data/quick_actions.dart';
import 'package:aniu/pages/router.dart';

List<QuickActionsDisplayData> displayQuickActions = [
  QuickActionsDisplayData('Помочь сайту', 'Накинь касарик пожалуйста', toDonatePage, 'balloon', null),
  QuickActionsDisplayData('Топ', 'Пользователей сайта', toTopUsersPage, 'histogram', null),
  QuickActionsDisplayData('Рандом', 'Случайное аниме', toRandomPage, 'dice', null),
  QuickActionsDisplayData('Избранное', 'Только самое ценное', toFavouritesPage, 'heart', 'favorite'),
  QuickActionsDisplayData('Коллекции', 'От Anixart', toCollectionsPage, 'slides', null),
  QuickActionsDisplayData('Правила сайта', 'Много важных букв', toRulesPage, 'routes', null),
];
List<QuickActionsDisplayData> displayMyLists = [
  QuickActionsDisplayData('Смотрю', 'Пожалуй, самое важное место', toFavouritesPage, '1', 'watching'),
  QuickActionsDisplayData('Просмотрено', 'Похвастайся перед друзьями', toFavouritesPage, '2', 'completed'),
  QuickActionsDisplayData('Запланировано', 'Не забудь, это важно!', toFavouritesPage, '3', 'plan'),
  QuickActionsDisplayData('Отложено', 'Возможно, когда-нибудь я вернусь к этому', toFavouritesPage, '4', 'hold'),
];