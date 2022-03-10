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
  const Release({this.id, this.anixart, this.kinopoisk, this.kinopoiskRating, this.kodikId, this.shikimori, this.shikimoriRating, this.imdb, this.imdbRating, this.myAnimeList, this.myDoramaLint, this.poster, this.year, this.genres, this.country, this.director, this.author, this.translators, this.studio, this.description, this.note, this.category, this.status, this.ageRating, this.rating, this.titleOriginal, this.titleRu, this.titleAlt, this.titleJap, this.franchise, this.episodesReleased, this.episodesTotal, this.season, this.releaseDate, this.airedDate, this.creationDate, this.lastUpdateDate, this.group, this.sub, this.threeD, this.kind, this.duration, this.chibi, this.isBan, this.list});
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

class MaterialData {

  final String? title; //"Сасаки и Мияно",
  final String? animeTitle; //"Сасаки и Мияно",
  final String? titleEn; //"Sasaki to Miyano",
  final List<String>? otherTitles; //["Sasamiya"],
  final List<String>? otherTitlesEn; //["Sasaki and Miyano"],
  final List<String>? otherTitlesJp; //["佐々木と宮野"],
  final String? animeLicenseName; //"Сасаки и Мияно",
  final String? animeLicensedBy; //["Wakanim"],
  final String? animeKind; //"tv",
  final String? allStatus; //"ongoing",
  final String? animeStatus; //"ongoing",
  final String? description; //"Ничто не нарушало мирных будней Ёсикадзу Мияно: он учился,
  final String? animeDescription; //"Ничто не нарушало мирных будней Ёсикадзу Мияно: он учился,
  final String? posterUrl; //"https://st.kp.yandex.net/images/film_big/4557186.jpg",
  final List<String>? screenshots; //["https://shikimori.one/system/screenshots/original/158979ea6daf47fad1e8219942e6d21495ad5079.jpg",
  final String? https; //shikimori.one/system/screenshots/original/0d6161df014369b2f8e23a8b0dba4709c87a8023.jpg"],
  final double? duration; //23,
  final String? countries; //["Япония"],
  final List<String>? allGenres;
  final List<String>? genres;
  final List<String>? animeGenres;
  final List<String>? animeStudios;
  final double? imdbRating; //7.6,
  final int? imdbVotes; //136,
  final double? shikimoriRating; //7.93,
  final int? shikimoriVotes; //342,
  final String? premiereWorld; //"2022-01-10",
  final String? airedAt; //"2022-01-10",
  final String? releasedAt; //"2022-03-28",
  final String? nextEpisodeAt; //"2022-02-20T15:30:00Z",
  final String? ratingMpaa; //"PG-13",
  final int? minimalAge; //18,
  final int? episodesTotal; //12,
  final int? episodesAired; //6,
  final List<String>? actors;
  final List<String>? directors;
  final List<String>? writers;

  MaterialData(
      this.title,
      this.animeTitle,
      this.titleEn,
      this.otherTitles,
      this.otherTitlesEn,
      this.otherTitlesJp,
      this.animeLicenseName,
      this.animeLicensedBy,
      this.animeKind,
      this.allStatus,
      this.animeStatus,
      this.description,
      this.animeDescription,
      this.posterUrl,
      this.screenshots,
      this.https,
      this.duration,
      this.countries,
      this.allGenres,
      this.genres,
      this.animeGenres,
      this.animeStudios,
      this.imdbRating,
      this.imdbVotes,
      this.shikimoriRating,
      this.shikimoriVotes,
      this.premiereWorld,
      this.airedAt,
      this.releasedAt,
      this.nextEpisodeAt,
      this.ratingMpaa,
      this.minimalAge,
      this.episodesTotal,
      this.episodesAired,
      this.actors,
      this.directors,
      this.writers);
}
class User {
  final String? avatar; //: "https://lh3.googleusercontent.com/a-/AOh14Gj4tn3HTQRCAu7xSJxJsHp462i21ycTaZEaSf8n_w=s96-c"
  final String? banReason; //: null
  final String? gender; //: "0"
  final String? id; //: "10479"
  final String? isBanned; //: "0"
  final String? link; //: null
  final String? login; //: "GlebWul"
  final String? status; //: null
  final bool? team; //: false
  final String? userGroupId;

  User({
    this.avatar, this.banReason, this.gender, this.id, this.isBanned,
    this.link, this.login, this.status, this.team, this.userGroupId
  }); //: "1"

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        avatar : json['avatar'] as String?,
        banReason : json['ban_reason'] as String?,
        gender : json['gender'] as String?,
        id : json['id'] as String?,
        isBanned : json['is_banned'] as String?,
        link : json['link'] as String?,
        login : json['login'] as String?,
        status : json['status'] as String?,
        team : json['team'] as bool?,
        userGroupId : json['user_group_id'] as String?
    );
  }

}

class Comment {
  final String? id; //: "1321674"
  final bool? imVote; //: false
  final String? isDeleted; //: "0"
  final String? isEdited; //: "0"
  final String? isSpoiler; //: "0"
  final int? likesCount; //: 1
  final String? message; //: "#ДЕДРЕШАЛА #ДЕДАВГЛАВНЫЕРОЛИ"
  final String? release; //: "15810"
  final int? replyCount; //: 0
  final String? timestamp; //: "15 часов назад"
  final String? title; //: "Слова пузырятся подобно газировке"
  final User? user;

  Comment({
      this.id,
      this.imVote,
      this.isDeleted,
      this.isEdited,
      this.isSpoiler,
      this.likesCount,
      this.message,
      this.release,
      this.replyCount,
      this.timestamp,
      this.title,
    this.user
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id : json['id'] as String?,
        imVote : json['im_vote'] as bool?,
        isDeleted : json['is_deleted'] as String?,
        isEdited : json['is_edited'] as String?,
        isSpoiler : json['is_spoiler'] as String?,
        likesCount : json['likes_count'] as int?,
        message : json['message'] as String?,
        release : json['release'] as String?,
        replyCount : json['reply_count'] as int?,
        timestamp : json['timestamp'] as String?,
        title : json['title'] as String?,
        user : User.fromJson(json['user']),
    );
  }
}
