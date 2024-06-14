class Comment {
  Comment({
    required this.comment_id,
    required this.uid,
    required this.warehouse_id,
    required this.contents,
    required this.created_at,
  });
  final int comment_id;
  final String uid;
  final int warehouse_id;
  final String contents;
  final String created_at;
}
