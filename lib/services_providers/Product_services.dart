// ignore_for_file: file_names

import 'package:blog_app/controllers/product_controller.dart';
import 'package:blog_app/models/product/es_product.dart';
import 'package:blog_app/utils/struct_response.dart';

class ProductServices {
  Future<EsProduct> getProducts() async {
    StructResponse serviceResponse = StructResponse();
    EsProduct esCategories = await ProductController.getAll(5, 1);
    serviceResponse.response = esCategories;

    return esCategories;
  }
}
