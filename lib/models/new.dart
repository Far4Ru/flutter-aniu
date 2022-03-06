import 'dart:core';

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
  final String? titleAlt;//Lan Di\r\nЛань Ди\r\nRyou Hazuki\r\nРё Хадзуки
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
  const Release({this.id, this.anixart, this.kinopoisk, this.kinopoiskRating, this.kodikId, this.shikimori, this.shikimoriRating, this.imdb, this.imdbRating, this.myAnimeList, this.myDoramaLint, this.poster, this.year, this.genres, this.country, this.director, this.author, this.translators, this.studio, this.description, this.note, this.category, this.status, this.ageRating, this.rating, this.titleOriginal, this.titleRu, this.titleAlt, this.titleJap, this.franchise, this.episodesReleased, this.episodesTotal, this.season, this.releaseDate, this.airedDate, this.creationDate, this.lastUpdateDate, this.group, this.sub, this.threeD, this.kind, this.duration, this.chibi, this.isBan, this.list});
  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      id: json['id'],
      anixart: json['anixart'],
      kinopoisk: json['kinopoisk'],
      kinopoiskRating: json['kinopoisk_rating'],
      kodikId: json['kodik_id'],
      shikimori: json['shikimori'],
      shikimoriRating: json['shikimori_rating'],
      imdb: json['imdb'],
      imdbRating: json['imdb_rating'],
      myAnimeList: json['myanimelist'],
      myDoramaLint: json['myDoramaLint'],
      poster: json['poster'],
      year: json['year'],
      genres: json['genres'],
      country: json['country'],
      director: json['director'],
      author: json['author'],
      translators: json['translators'],
      studio: json['studio'],
      description: json['description'],
      note: json['note'],
      category: json['category'],
      status: json['status'],
      ageRating: json['age_rating'],
      rating: json['rating'],
      titleOriginal: json['title_original'],
      titleRu: json['title_ru'],
      titleAlt: json['title_alt'],
      titleJap: json['title_jap'],
      franchise: json['franchise'],
      episodesReleased: json['episodes_released'],
      episodesTotal: json['episodes_total'],
      season: json['season'],
      releaseDate: json['release_date'],
      airedDate: json['aired_date'],
      creationDate: json['creation_date'],
      lastUpdateDate: json['last_update_date'],
      group: json['group'],
      sub: json['sub'],
      threeD: json['3d'],
      kind: json['kind'],
      duration: json['duration'],
      chibi: json['chibi'],
      isBan: json['is_ban'],
      list: json['list']
    );
  }
}