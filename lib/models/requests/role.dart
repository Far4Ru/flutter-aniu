import 'package:aniu/models/requests/character.dart';

class Role {
  final List? roles; //: "Main"
  final List? rolesRussian; //: "Main"
  final int? releaseId; //: 1067
  final Character? character;

  Role( {
    this.roles,
    this.rolesRussian,
    this.releaseId,
    this.character
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roles: json['roles'] as List?,
      rolesRussian: json['roles_russian'] as List?,
      releaseId: json['_release'] as int?,
      character: Character.fromJson(json['character']),
    );
  }
}