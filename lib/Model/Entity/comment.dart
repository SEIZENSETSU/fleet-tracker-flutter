class Comment {
  final int? id;
  final String uid;
  final int warehouseId;
  final String contents;
  final String? createdAt;

  Comment({
    this.id,
    required this.uid,
    required this.warehouseId,
    required this.contents,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['comment_id'],
      uid: json['uid'],
      warehouseId: json['warehouse_id'],
      contents: json['contents'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': id,
      'uid': uid,
      'warehouse_id': warehouseId,
      'contents': contents,
      'created_at': createdAt,
    };
  }
}
