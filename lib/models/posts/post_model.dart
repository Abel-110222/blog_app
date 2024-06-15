// ignore_for_file: non_constant_identifier_names

import 'package:blog_app/models/auth/user_model.dart';
import 'package:blog_app/models/comment_model.dart';

class PostModel {
  final String id;
  final String user_id;
  final String title;
  final String content;
  final String image_url;
  final DateTime createdAt;
  final DateTime updatedAt;
  UserModel? user;
  List<CommentModel>? comments;

  PostModel({
    required this.id,
    required this.user_id,
    required this.title,
    required this.content,
    required this.image_url,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var commentsJson = json['Comments'] as List;
    List<CommentModel> commentList = commentsJson.map((i) => CommentModel.fromJson(i)).toList();

    return PostModel(
      id: json['id'] ?? '',
      user_id: json['user_id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image_url: json['image_url'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: json['user'] == null ? null : UserModel.fromJson(json['user']),
      comments: commentList,
    );
  }
}
