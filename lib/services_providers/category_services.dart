import 'package:blog_app/controllers/category_controller.dart';
import 'package:blog_app/models/category/es_categories.dart';
import 'package:blog_app/utils/struct_response.dart';

class CategoryServices {
  Future<EsCategories> getCategories() async {
    StructResponse serviceResponse = StructResponse();
    EsCategories esCategories = await CategoryController.getAll(5, 1);
    serviceResponse.response = esCategories;

    return esCategories;
  }
}
