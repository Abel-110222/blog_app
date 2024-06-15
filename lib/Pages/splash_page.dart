import 'package:blog_app/controllers/login_controller.dart';
import 'package:blog_app/models/auth/user_model.dart';
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/utils/responsive.dart';
import 'package:blog_app/widgets/my_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String loginPageRoute = 'LoginPageRoute';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  bool textInvalid = false;
  GlobalKey<FormState> formKey = GlobalKey();
  bool activo = false;
  TextEditingController userController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureTextPassword = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController.text = "admin@email.com";
    passwordController.text = "123456";
  }

  void login() async {
    final isOk = formKey.currentState!.validate();
    if (isOk) {
      String name = userController.text;
      String email = usernameController.text;
      String password = passwordController.text;

      DefaultStructHttpResponse response = isLogin
          ? await LoginController.login(email, password)
          : await LoginController.register(name, email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convierte la respuesta JSON a UserModel
        // Decodifica la respuesta JSON y accede al valor anidado bajo "user"
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        Map<String, dynamic> userJson = responseBody['user'];

        // Convierte el JSON del usuario a UserModel
        UserModel user = UserModel.fromJson(userJson);

        // Imprime los valores del UserModel para depuración
        print('Username: ${user.username}');
        print('Email: ${user.email}');
        print('Password Hash: ${user.passwordHash}');
        print('Created At: ${user.createdAt}');
        print('Updated At: ${user.updatedAt}');

        // Guarda el UserModel en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user.toJson()));

        Navigator.pushNamed(
          context,
          'view_Home',
        );
      } else {
        setState(() {
          textInvalid = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    double widthScreen = 650;
    bool mustBePortrait = resp.width < 650;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: Scaffold(
        body: GestureDetector(
          child: ListView(
            children: [
              Center(
                child: SizedBox(
                  width: widthScreen,
                  height: resp.heightPercent(100) < 350 ? 350 : resp.heightPercent(100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ///!  Panel Information
                      mustBePortrait
                          ? Container(
                              width: 0,
                              height: 350,
                              color: Colors.green[500],
                            )
                          : Container(
                              width: 375,
                              height: isLogin ? 350 : 450,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(0,
                                        5), // Ajusta el offset para mover la sombra hacia la derecha
                                    blurRadius: 7,
                                    spreadRadius: 0, // Cambia el spreadRadius según sea necesario
                                  ),
                                ],
                              ),
                              child: CustomPaint(
                                  painter: CustomShapePainter(), child: panelInformation()),
                            ),

                      ///!  Panel Data Input
                      Container(
                        width: 275,
                        height: isLogin ? 350 : 450,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: Offset(
                                  10, 0), // Ajusta el offset para mover la sombra hacia la derecha
                              blurRadius: 7,
                              spreadRadius: 0, // Cambia el spreadRadius según sea necesario
                            ),
                          ],
                        ),
                        child: panelDataInput(
                          mustBePortrait ? true : false,
                          resp,
                          440,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            FocusScope.of(context).unfocus();
          },
        ),
      ),
    );
  }

  Widget panelInformation() {
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.passthrough,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const SizedBox(height: 35),
            const SizedBox(height: 55),
            const SizedBox(height: 30),
          ],
        ),

        ///!  Copy Right
        Positioned(
          left: 15,
          bottom: 75,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              " ",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget panelDataInput(
    bool showEtecno,
    Responsive pResp,
    double pHeight,
  ) {
    return Form(
      key: formKey,
      autovalidateMode: activo ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      child: SizedBox(
        height: pHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///
            Expanded(
              flex: 10,
              child: SizedBox(
                child: Column(
                  children: <Widget>[
                    ///
                    ///!  Logo KananFleet
                    const SizedBox(height: 35),
                    Container(
                      height: 39,
                      child: Text("Bienvenido",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                    ),

                    ///!  User
                    const SizedBox(height: 10),
                    Visibility(
                      visible: !isLogin,
                      child: Container(
                        height: isLogin ? 0 : 60,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Card(
                          elevation: 5,
                          child: MyTextFormField(
                            label: 'Nombre',
                            textEditingController: userController,
                            backColor: Colors.white,
                            fontSize: pResp.isWeb ? 13 : 15,
                            borderWrap: false,
                            showUnderLine: false,
                            underLineColor: Colors.grey,
                            fontSizeLabel: pResp.isWeb ? 12 : 14,
                            borderCircularSize: 5,
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              if (text!.trim().length <= 3) {
                                return 'Nombre invalido';
                              }
                              return null;
                            },
                            onChanged: (text) {},
                          ),
                        ),
                      ),
                    ),

                    ///!  User
                    const SizedBox(height: 10),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Card(
                        elevation: 5,
                        child: MyTextFormField(
                          label: 'Email',
                          textEditingController: usernameController,
                          backColor: Colors.white,
                          fontSize: pResp.isWeb ? 13 : 15,
                          borderWrap: false,
                          showUnderLine: false,
                          underLineColor: Colors.grey,
                          fontSizeLabel: pResp.isWeb ? 12 : 14,
                          borderCircularSize: 5,
                          keyboardType: TextInputType.emailAddress,
                          validator: (text) {
                            if (textInvalid) {
                              return 'Correo o contraseña incorrecta';
                            } else {
                              if (text!.trim().length <= 3) {
                                return 'Email invalido';
                              }
                            }

                            return null;
                          },
                          onChanged: (text) {},
                        ),
                      ),
                    ),

                    ///!  Password
                    //////!  Password
                    const SizedBox(height: 7),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Card(
                        elevation: 5,
                        child: MyTextFormField(
                            label: 'Contraseña',
                            textEditingController: passwordController,
                            backColor: Colors.white,
                            borderWrap: false,
                            showUnderLine: false,
                            fontSize: pResp.isWeb ? 13 : 15,
                            fontSizeLabel: pResp.isWeb ? 12 : 14,
                            borderCircularSize: 5,
                            obscureText: obscureTextPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureTextPassword = !obscureTextPassword;
                                });
                              },
                              icon: Tooltip(
                                message: "Mostrar contraseña",
                                child: Icon(
                                  obscureTextPassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.password,
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (textInvalid) {
                                return 'Correo o contraseña incorrecta';
                              } else {
                                if (text!.trim().length <= 3) {
                                  return 'Contraseña invalida';
                                }
                              }
                              return null;
                            },
                            onChanged: (text) {},
                            onFieldSubmitted: (text) {}),
                      ),
                    ),

                    ///    ///!  Password
                    ///!  User
                    const SizedBox(height: 10),
                    Visibility(
                      visible: !isLogin,
                      child: Container(
                        height: isLogin ? 0 : 60,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Card(
                          elevation: 5,
                          child: MyTextFormField(
                              label: 'Confirmar contraseña',
                              textEditingController: passwordController,
                              backColor: Colors.white,
                              borderWrap: false,
                              showUnderLine: false,
                              fontSize: pResp.isWeb ? 13 : 15,
                              fontSizeLabel: pResp.isWeb ? 12 : 14,
                              borderCircularSize: 5,
                              obscureText: obscureTextPassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureTextPassword = !obscureTextPassword;
                                  });
                                },
                                icon: Tooltip(
                                  message: "Mostrar contraseña",
                                  child: Icon(
                                    obscureTextPassword
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.password,
                                    color: Colors.black38,
                                  ),
                                ),
                              ),
                              validator: (text) {
                                if (text!.trim().length <= 3) {
                                  return 'La contraseña debe tener al menos 4 caracteres';
                                }
                                return null;
                              },
                              onChanged: (text) {},
                              onFieldSubmitted: (text) {
                                setState(() {
                                  activo = true;
                                });
                                login();
                              }),
                        ),
                      ),
                    ),

                    // const SizedBox(height: 7),
                    // Container(
                    //   height: 60,
                    //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    //   child: Card(
                    //     elevation: 2,
                    //     child: TextFormField(
                    //       controller: passwordController,
                    //       decoration: InputDecoration(
                    //         labelText: 'Contraseña',
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //         ),
                    //         suffixIcon: IconButton(
                    //           onPressed: () {},
                    //           icon: const Icon(
                    //             Icons.remove_red_eye_outlined,
                    //             color: Colors.black38,
                    //           ),
                    //         ),
                    //       ),
                    //       obscureText: false,
                    //       validator: (text) {
                    //         if (text!.trim().length <= 3) {
                    //           return 'La contraseña debe tener al menos 4 caracteres';
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //   ),
                    // ),

                    ///!  Button Log In
                    const SizedBox(height: 7),
                    SizedBox(
                      height: 40,
                      width: 238,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 244, 132, 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), // Bordes cuadrados
                          ),
                          elevation: 5, // Añadir sombra
                          shadowColor: Colors.grey, // Color de la sombra
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            obscureTextPassword = true;
                            activo = true;
                          });
                          login();
                        },
                      ),
                    ),

                    ///!  Forgot Password
                    const SizedBox(height: 0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin ? 'Registrarse' : 'Ya tengo cuenta',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.6, 0)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.25, size.width * 0.8, size.height * 0.5)
      ..quadraticBezierTo(size.width, size.height * 0.75, size.width * 0.8, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
