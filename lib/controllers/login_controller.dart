import 'package:blog_app/utils/globals.dart' as global;
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/utils/http_getpost_response.dart';

abstract class LoginController {
  static Future<DefaultStructHttpResponse> login(String email, String password) async {
    Map<String, Object> body = {
      "email": email,
      "password": password,
    };
    String apiUrl = '/auth/login';

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

  static Future<DefaultStructHttpResponse> register(
      String name, String email, String password) async {
    Map<String, Object> body = {
      "username": name,
      "email": email,
      "password": password,
    };
    String apiUrl = '/auth/register';

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
