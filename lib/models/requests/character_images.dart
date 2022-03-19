class CharacterImages{
  final String? original; //: "https://aniu.ru//characters//36828.jpg"
  final String? shikimori; //: "https://shikimori.one//system//characters//original//36828.jpg?1644275296"
  final String? shikimoriAlt; //: "https://shikimori.org//system//characters//original//36828.jpg?1644275296" [broken link?]

  CharacterImages({
    this.original,
    this.shikimori,
    this.shikimoriAlt,
  });

  factory CharacterImages.fromJson(Map<String, dynamic> json) {
    return CharacterImages(
      original: json['original'] as String?,
      shikimori: json['shikimori'] as String?,
      shikimoriAlt: json['shikimori_alt'] as String?,
    );
  }
}