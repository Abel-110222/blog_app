import 'dart:convert';

import 'package:blog_app/models/organization/es_organization.dart';
import 'package:blog_app/utils/en_info.dart';
import 'package:blog_app/utils/globals.dart' as global;
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/utils/http_getpost_response.dart';

abstract class OrganizationController {
  ///
  ///!  *************************************************************
  ///!  API ORGANIZACIÓN: "Consultar Organizaciones (Get All)"
  ///!  *************************************************************
  static Future<EsOrganization> getAll(int top, int usuarioId) async {
    Map<String, Object> body = {};
    String apiUrl = '/organizations';
    return runAPIPost(body, apiUrl);
  }

  ///!  ---------------------------------------------------------------
  ///!  RUN API ORGANIZACIÓN
  ///
  static Future<EsOrganization> runAPIPost(
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
      EsOrganization catchEs = EsOrganization();
      catchEs.info = EnInfo();
      return catchEs;
    }
  }

  ///!  ---------------------------------------------------------------
  ///!  Cast Response to EsOrganization
  ///
  static EsOrganization castResponseToEs(
    DefaultStructHttpResponse defaultHttpResponse,
  ) {
    ///
    EsOrganization struct = EsOrganization();
    struct.info = EnInfo();
    //!
    if (defaultHttpResponse.body == '') {
      struct.success = false;
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
  static EsOrganization esFromJson(String responseBody) =>
      EsOrganization.fromJson(json.decode(responseBody));
}
