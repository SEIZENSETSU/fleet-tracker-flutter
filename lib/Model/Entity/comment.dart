class Comment {
  Comment({
    this.id,
    required this.uid,
    required this.warehouseId,
    required this.contents,
    this.createdAt,
  });
  final int? id;
  final String uid;
  final int warehouseId;
  final String contents;
  final String? createdAt;
}
