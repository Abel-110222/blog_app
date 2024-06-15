// ignore_for_file: non_constant_identifier_names

import 'package:blog_app/models/category/categories_model.dart';
import 'package:blog_app/utils/en_info.dart';
import 'package:blog_app/utils/es_estructura.dart';

class EsCategories extends EsEstructura {
  bool success = false;
  List<Categories>? categories = [];

  EsCategories({
    this.success = false,
    this.categories,

    ///!
    super.info,
  });
  factory EsCategories.fromJson(Map<String, dynamic> json) => EsCategories(
        success: json["success"] ?? false,
        categories: json["categories"] == null
            ? null
            : List<Categories>.from(json["categories"].map((x) => Categories.fromJson(x))),

        ///
        info: json["info"] == null ? null : EnInfo.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "categories": categories,
        "info": info,
      };
}
