import 'package:aniu/models/requests/character.dart';
class Role {
  // final String? role; //: "Main"
  // final String? roleRu; //: "Main"
  final int? releaseId; //: 1067
  final Character? character;

  Role( {
    // this.role,
    // this.roleRu,
    this.releaseId,
    this.character
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      // role: json['roles'] as String?,
      // roleRu: json['roles_russian'] as String?,
      releaseId: json['_release'] as int?,
      character: Character.fromJson(json['character']),
    );
  }
}