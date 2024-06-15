import 'dart:convert';

import 'package:blog_app/utils/en_info.dart';
import 'package:blog_app/models/category/es_categories.dart';
import 'package:blog_app/utils/globals.dart' as global;
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/utils/http_getpost_response.dart';

abstract class CategoryController {
  ///
  ///!  *************************************************************
  ///!  API MARCA: "Consultar Marcas (Get All)"
  ///!  *************************************************************
  static Future<EsCategories> getAll(int top, int usuarioId) async {
    Map<String, Object> body = {};
    String apiUrl = '/categories';
    return runAPIPost(body, apiUrl);
  }

  ///!  ---------------------------------------------------------------
  ///!  RUN API MARCA
  ///
  static Future<EsCategories> runAPIPost(
    Map<String, dynamic> post,
    String apiUrl,
  ) async {
    ///
    String strJsonEncode = jsonEncode(post);

    Uri url = Uri.parse(
      '${global.urlAPIs}$apiUrl',
    );

    try {
      DefaultStructHttpResponse defaultHttpResponse = await httpGetPostResponse(
        'GET',
        apiUrl,
        url,
        strJsonEncode,
        1,
        10,
      );

      return castResponseToEs(defaultHttpResponse);
    } catch (ex) {
      EsCategories catchEs = EsCategories();
      catchEs.info = EnInfo();
      return catchEs;
    }
  }

  ///!  ---------------------------------------------------------------
  ///!  Cast Response to EsMarca
  ///
  static EsCategories castResponseToEs(
    DefaultStructHttpResponse defaultHttpResponse,
  ) {
    ///
    EsCategories struct = EsCategories();
    struct.info = EnInfo();
    //!
    if (defaultHttpResponse.body == '') {
      struct.success = false;

      // struct.error?.mensaje = defaultHttpResponse.message;
      // struct.propiedad!.id = 2;
      // struct.propiedad?.mensaje = defaultHttpResponse.message;
    } else {
      if (defaultHttpResponse.success) {
        struct = esFromJson(defaultHttpResponse.body);
      } else {
        // struct.error?.fuente = '0';
        // struct.error?.mensaje = defaultHttpResponse.message;
      }
    }

    return struct;
  }

  ///!  ---------------------------------------------------------------
  ///!  Struct To FromJson
  ///
  // static EsCategories esFromJson(String responseBody) =>
  //     EsCategories.fromJson(json.decode(responseBody));
  static EsCategories esFromJson(String responseBody) =>
      EsCategories.fromJson(json.decode(responseBody));
}
