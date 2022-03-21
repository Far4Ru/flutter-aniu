class Release {
  final String? id;
  final String? anixart;
  final String? kinopoisk;
  final String? kinopoiskRating; //null
  final String? kodikId;//serial-40638
  final String? shikimori;
  final String? shikimoriRating;//6.84
  final String? imdb; //null
  final String? imdbRating; //null
  final String? myAnimeList;//42808
  final String? myDoramaLint;//null
  final String? poster;//2d26d7524e5ae2cf623d71c0db915e74
  final String? year;//2022
  final String? genres;//экшен, приключения
  final String? country;//Япония
  final String? director;//null
  final String? author;//null
  final String? translators;//null
  final String? studio;//Telecom Animation Film
  final String? description;//После того, как он становится свидетелем убийства своего отца в семейном додзё, Хадзуки Рё посвящает свою жизнь поиску виновного — миссии, которая переносит его с улиц Йокосуки в Японии в огромный мегаполис Гонконг и дальше. Вскоре он узнает, что в игру вступают более крупные мистические силы, поскольку он тренируется, чтобы стать лучшим мастером боевых искусств в своем стремлении отомстить.
  final String? note;//null
  final String? category;//null
  final String? status;//ongoing
  final String? ageRating;//null
  final String? rating;
  final String? titleOriginal;//Shenmue the Animation
  final String? titleRu;//Шэнму
  final String? titleAlt;//Lan DirnЛань ДиrnRyou HazukirnРё Хадзуки
  final String? titleJap;//シェンムー
  final String? franchise;//shenmue
  final String? episodesReleased;//2
  final String? episodesTotal;//13
  final String? season;//unknown
  final String? releaseDate;//null
  final String? airedDate;//2022-02-06
  final String? creationDate;//2022-02-06 12:03:32
  final String? lastUpdateDate;//2022-03-03 21:12:49
  final String? group;//null
  final String? sub;//0
  final String? threeD;//0
  final String? kind;//tv
  final String? duration;//23
  final String? chibi;//0
  final String? isBan;//0
  final String? list;//null

  const Release({
    this.id,
    this.anixart,
    this.kinopoisk,
    this.kinopoiskRating,
    this.kodikId,
    this.shikimori,
    this.shikimoriRating,
    this.imdb,
    this.imdbRating,
    this.myAnimeList,
    this.myDoramaLint,
    this.poster,
    this.year,
    this.genres,
    this.country,
    this.director,
    this.author,
    this.translators,
    this.studio,
    this.description,
    this.note,
    this.category,
    this.status,
    this.ageRating,
    this.rating,
    this.titleOriginal,
    this.titleRu,
    this.titleAlt,
    this.titleJap,
    this.franchise,
    this.episodesReleased,
    this.episodesTotal,
    this.season,
    this.releaseDate,
    this.airedDate,
    this.creationDate,
    this.lastUpdateDate,
    this.group,
    this.sub,
    this.threeD,
    this.kind,
    this.duration,
    this.chibi,
    this.isBan,
    this.list
  });

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      id: json['id'] as String?,
      anixart: json['anixart'] as String?,
      kinopoisk: json['kinopoisk'] as String?,
      kinopoiskRating: json['kinopoisk_rating'] as String?,
      kodikId: json['kodik_id'] as String?,
      shikimori: json['shikimori'] as String?,
      shikimoriRating: json['shikimori_rating'] as String?,
      imdb: json['imdb'] as String?,
      imdbRating: json['imdb_rating'] as String?,
      myAnimeList: json['myanimelist'] as String?,
      myDoramaLint: json['myDoramaLint'] as String?,
      poster: json['poster'] as String?,
      year: json['year'] as String?,
      genres: json['genres'] as String?,
      country: json['country'] as String?,
      director: json['director'] as String?,
      author: json['author'] as String?,
      translators: json['translators'] as String?,
      studio: json['studio'] as String?,
      description: json['description'] as String?,
      note: json['note'] as String?,
      category: json['category'] as String?,
      status: json['status'] as String?,
      ageRating: json['age_rating'] as String?,
      rating: json['rating'] as String?,
      titleOriginal: json['title_original'] as String?,
      titleRu: json['title_ru'] as String?,
      titleAlt: json['title_alt'] as String?,
      titleJap: json['title_jap'] as String?,
      franchise: json['franchise'] as String?,
      episodesReleased: json['episodes_released'] as String?,
      episodesTotal: json['episodes_total'] as String?,
      season: json['season'] as String?,
      releaseDate: json['release_date'] as String?,
      airedDate: json['aired_date'] as String?,
      creationDate: json['creation_date'] as String?,
      lastUpdateDate: json['last_update_date'] as String?,
      group: json['group'] as String?,
      sub: json['sub'] as String?,
      threeD: json['3d'] as String?,
      kind: json['kind'] as String?,
      duration: json['duration'] as String?,
      chibi: json['chibi'] as String?,
      isBan: json['is_ban'] as String?,
      list: json['list'] as String?
    );
  }

  getVideoLink() {
    if (titleOriginal != null && id != null) {
      return 'https://aniu.ru/anime/'+titleOriginal!.replaceAll(' ', '_')+'-'+id!+'/player';
    } else {
      return '';
    }
  }
}