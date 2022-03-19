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