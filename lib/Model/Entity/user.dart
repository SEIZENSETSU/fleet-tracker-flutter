class User {
  final String uid;
  final String name;
  final String? fcmTokenId;

  User({
    required this.uid,
    required this.name,
    this.fcmTokenId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['user_name'],
      fcmTokenId: json['fcm_token_id'],
    );
  }
}
