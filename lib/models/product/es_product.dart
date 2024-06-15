// ignore_for_file: non_constant_identifier_names

import 'package:blog_app/models/product/Product_Model.dart';
import 'package:blog_app/utils/en_info.dart';
import 'package:blog_app/utils/es_estructura.dart';

class EsProduct extends EsEstructura {
  bool success = false;
  List<ProductModel>? products = [];

  EsProduct({
    this.success = false,
    this.products,

    ///!
    super.info,
  });
  factory EsProduct.fromJson(Map<String, dynamic> json) => EsProduct(
        success: json["success"] ?? false,
        products: json["products"] == null
            ? null
            : List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),

        ///
        info: json["info"] == null ? null : EnInfo.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": products,
        "info": info,
      };
}
