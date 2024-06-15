import 'dart:convert';
import 'package:blog_app/utils/globals.dart' as global;
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/utils/http_getpost_response.dart';

abstract class PostController {
  static Future<DefaultStructHttpResponse> getAll(String email, String password) async {
    Map<String, Object> body = {
      "email": email,
      "password": password,
    };
    String apiUrl = '/posts/';

    try {
      DefaultStructHttpResponse defaultHttpResponse = await httpGetPostResponse(
        'GET',
        'Login',
        Uri.parse('${global.urlAPIs}$apiUrl'),
        body,
        1,
        10,
        true, // Mostrar detalles de la respuesta en modo de depuración
      );

      return defaultHttpResponse;
    } catch (ex) {
      DefaultStructHttpResponse defaultHttpResponse = DefaultStructHttpResponse();
      defaultHttpResponse.message = 'Error en login: $ex';
      return defaultHttpResponse;
      // Manejar errores de red u otros errores
    }
  }

  static Future<DefaultStructHttpResponse> create(
      String title, String content, String image_url) async {
    Map<String, Object> body = {
      "title": title,
      "content": content,
      "image_url": image_url,
    };
    String apiUrl = '/posts/';

    try {
      DefaultStructHttpResponse defaultHttpResponse = await httpGetPostResponse(
        'POST',
        'Login',
        Uri.parse('${global.urlAPIs}$apiUrl'),
        body,
        1,
        10,
        true, // Mostrar detalles de la respuesta en modo de depuración
      );

      return defaultHttpResponse;
    } catch (ex) {
      DefaultStructHttpResponse defaultHttpResponse = DefaultStructHttpResponse();
      defaultHttpResponse.message = 'Error en login: $ex';
      return defaultHttpResponse;
      // Manejar errores de red u otros errores
    }
  }

  static Future<DefaultStructHttpResponse> createComment(String content, String id) async {
    Map<String, Object> body = {
      "content": id,
    };
    String apiUrl = '/comments/$content';

    try {
      DefaultStructHttpResponse defaultHttpResponse = await httpGetPostResponse(
        'POST',
        'Login',
        Uri.parse('${global.urlAPIs}$apiUrl'),
        body,
        1,
        10,
        true, // Mostrar detalles de la respuesta en modo de depuración
      );

      return defaultHttpResponse;
    } catch (ex) {
      DefaultStructHttpResponse defaultHttpResponse = DefaultStructHttpResponse();
      defaultHttpResponse.message = 'Error en login: $ex';
      return defaultHttpResponse;
      // Manejar errores de red u otros errores
    }
  }
}
