import 'package:aniu/models/requests/character_images.dart';

class Character {
  final int? id; //: 36828
  final String? name; //: "Asuna Yuuki"
  final String? nameRu; //: "Асуна Юки"
  final String? shikimoriUrl; //: "/characters/36828-asuna-yuuki"
  final CharacterImages? images;

  Character({
    this.id,
    this.name,
    this.nameRu,
    this.shikimoriUrl,
    this.images,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id : json['id'] as int?,
      name: json['name'] as String?,
      nameRu: json['russian'] as String?,
      shikimoriUrl: json['url'] as String?,
      images : CharacterImages.fromJson(json['image']),
    );
  }
}

