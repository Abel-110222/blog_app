// ignore_for_file: non_constant_identifier_names

import 'package:blog_app/models/auth/user_model.dart';
import 'package:blog_app/models/category/categories_model.dart';
import 'package:blog_app/utils/en_info.dart';
import 'package:blog_app/utils/es_estructura.dart';

class EsUser extends EsEstructura {
  UserModel? user;

  EsUser({
    this.user,
  });
  factory EsUser.fromJson(Map<String, dynamic> json) => EsUser(
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),

        ///
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "info": info,
      };
}
