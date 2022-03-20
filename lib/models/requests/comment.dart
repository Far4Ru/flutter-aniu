import 'user.dart';

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
