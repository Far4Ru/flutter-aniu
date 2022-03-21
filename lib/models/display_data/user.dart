class UserDisplayData {
  String name;
  Map<String, int> stats;
  String poster;
  String avatar;
  String tag;
  String id;

  UserDisplayData(
    this.name,
    this.stats,
    this.poster,
    this.avatar,
    this.tag,
    this.id
  );

  translateStats(){
    Map<String, String> translateValues = {
      'Score': 'Рейтинг',
      'Friends' : 'Друзей',
      'Comments' : 'Комментариев',
      'Anime' : 'Аниме'
    };
    Map<String, int> newStats = {};
    for (var k in stats.keys) {
      String? translatedKey = translateValues[k];
      if(translatedKey != null) {
        newStats[translatedKey] = stats[k] ?? 0;
      }
    }
    stats = newStats;
  }
}