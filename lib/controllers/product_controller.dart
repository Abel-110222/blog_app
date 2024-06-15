import 'dart:convert';

import 'package:blog_app/models/product/es_product.dart';
import 'package:blog_app/utils/en_info.dart';
import 'package:blog_app/utils/globals.dart' as global;
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/utils/http_getpost_response.dart';

abstract class ProductController {
  ///
  ///!  *************************************************************
  ///!  API MARCA: "Consultar Marcas (Get All)"
  ///!  *************************************************************
  static Future<EsProduct> getAll(int top, int usuarioId) async {
    Map<String, Object> body = {};
    String apiUrl = '/products';
    return runAPIPost(body, apiUrl);
  }

  ///!  ---------------------------------------------------------------
  ///!  RUN API MARCA
  ///
  static Future<EsProduct> runAPIPost(
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
      EsProduct catchEs = EsProduct();
      catchEs.info = EnInfo();
      return catchEs;
    }
  }

  ///!  ---------------------------------------------------------------
  ///!  Cast Response to EsMarca
  ///
  static EsProduct castResponseToEs(
    DefaultStructHttpResponse defaultHttpResponse,
  ) {
    ///
    EsProduct struct = EsProduct();
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
  // static EsProduct esFromJson(String responseBody) =>
  //     EsProduct.fromJson(json.decode(responseBody));
  static EsProduct esFromJson(String responseBody) => EsProduct.fromJson(json.decode(responseBody));
}
