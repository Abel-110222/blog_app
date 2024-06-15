import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:blog_app/utils/default_struct_http_response.dart';

Future<DefaultStructHttpResponse> httpGetPostResponse(
  String request,
  String service,
  Uri url,
  Object body,
  int currentPage,
  int limit, [
  bool showResult = false,
]) async {
  url = url.replace();

  Map<String, String> headers = {
    "Content-type": "application/json",
    // Asegúrate de incluir el token de autorización adecuadamente aquí
    'Authorization':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1OGU3ZGZkYi1mMWRhLTRjMWQtODMxMC00ODY0MmEzMzc2ZWQiLCJpYXQiOjE3MTg0MjU1MTAsImV4cCI6MTcxOTAzMDMxMH0.PVOuD66EJLPO_j6XWYIw9G03kOaBPH2d0ltSA2MzMMQ',
    "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
    'Accept': '*/*'
  };

  DefaultStructHttpResponse defaultStruct = DefaultStructHttpResponse();

  try {
    http.Response? response;
    if (request == 'GET') {
      response = await http.get(url, headers: headers);
    } else if (request == 'POST') {
      String strJsonEncode = jsonEncode(body);
      response = await http.post(
        url,
        headers: headers,
        body: strJsonEncode,
      );
    }

    if (kDebugMode && showResult) {
      print('----response.ini: $url\n');
      print(response!.body);
      print('\n----response.end');
    }

    defaultStruct.body = response!.body;
    defaultStruct.statusCode = response.statusCode;

    if (!defaultStruct.success) {
      defaultStruct.message = 'Error en $service: Código de estado HTTP ${response.statusCode}';
    }
  } catch (ex) {
    defaultStruct.success = false;
    defaultStruct.message = "Error en $service: ${ex.toString()}";
  }

  return defaultStruct;
}
