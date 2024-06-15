// ignore_for_file: non_constant_identifier_names


class CommentModel {
  
  final String id;
  final String post_id;
  final String user_id;
  final String content;
   final DateTime createdAt;
  final DateTime updatedAt;




  CommentModel({
    required this.id,
    required this.post_id,
    required this.user_id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      post_id: json['post_id'],
      user_id: json['user_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': post_id,
      'user_id': user_id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}