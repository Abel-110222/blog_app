// ignore_for_file: unused_local_variable, sized_box_for_whitespace, use_build_context_synchronously, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:convert';

import 'package:blog_app/controllers/post_controller.dart';
import 'package:blog_app/models/auth/user_model.dart';
import 'package:blog_app/models/posts/post_model.dart';
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/bloc/theme.dart';
import 'package:blog_app/models/category/categories_model.dart';
import 'package:blog_app/models/organization/organization_model.dart';
import 'package:blog_app/models/product/Product_Model.dart';
import 'package:blog_app/utils/responsive.dart';
import 'package:blog_app/widgets/my_product_card.dart';
import 'package:blog_app/widgets/my_product_card_mobil.dart';
import 'package:blog_app/widgets/my_text_form_field.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  static String routeName = 'view_Home';
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //!-------------------------------
  //! Variables
  bool isLoading = false;
  bool showCard = true;
  bool showWriter = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showButton = false;
  int imageSizeInKilobytess = 0;

  ///
  ///!  *************************************************************
  ///!  GLOBALS KEYS
  ///!  *************************************************************
  ///
  //* GENERALES
  GlobalKey keyRespuesta = GlobalKey();

  ///!  *************************************************************
  ///!  TEXTE EDITING CONTROLLERS
  ///!  *************************************************************

  //*BUSCADOR SECUNDARIO
  TextEditingController respuestaController = TextEditingController();
  TextEditingController findControllerActividades = TextEditingController();
  final AutoScrollController _autoScrollController = AutoScrollController();

  ///
  ///!  *************************************************************
  ///!  FOCUS NODE
  ///!  *************************************************************

  //!-------------------------------
  //! Listas
  int currentIndex = 0; // Asegúrate de inicializar currentIndex
  int score = 0;
  List<Categories> categories = []; // Variable para almacenar las categorías
  List<ProductModel> products = [];
  List<OrganizationModel> organizations = [];
  List<ProductModel> filteredProducts = [];
  final ScrollController _scrollController = ScrollController();

  UserModel? myUser;
  List<PostModel> postsAll = [];

  @override
  void initState() {
    initData();
    super.initState();
    _autoScrollController.addListener(_scrollListener);
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  ///!  *************************************************************
  ///!  DISPOSE
  ///!  *************************************************************
  @override
  void dispose() {
    super.dispose();
    //general
  }

  Future<void> initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Lee el JSON guardado bajo la clave 'user'
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      // Decodifica el JSON a un mapa de Dart
      Map<String, dynamic> userMap = jsonDecode(userJson);
      myUser = UserModel.fromJson(userMap);

      // Verifica si el JSON contiene un objeto 'user' anidado
      Map<String, dynamic> nestedUser = userMap;

      // Crea una instancia de UserModel usando fromJson
      myUser = UserModel.fromJson(nestedUser);
      setState(() {});
      // Mostrar email del usuario (ejemplo de impresión)
    } else {
      if (kDebugMode) {
        print('No user data found in SharedPreferences');
      }
    }
    postsAll = [];
    DefaultStructHttpResponse response = await PostController.getAll("", "");

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Decodifica la respuesta JSON y accede al valor anidado bajo "user"
      List<dynamic> responseBody = jsonDecode(response.body);

      // Convierte el JSON a una lista de PostModel
      List<PostModel> posts = responseBody.map((json) => PostModel.fromJson(json)).toList();

      // Imprime los valores del PostModel para depuración
      for (PostModel post in posts) {
        postsAll.add(post);
      }
      setState(() {});
    }
  }

  Future<String> pickImageWeb() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    String? imageStr;

    if (image != null) {
      if (image.name.length >= 50) {
        setState(() {
          imageStr = '';
        });
        // myDialogWarning(context, gl.lanC[gl.lanD]!['app_imagen_nombreNO50Carac']!);
      } else {
        if (image != null) {
          var f = await image.readAsBytes();
          final int imageSize = f.length ~/ 1024;
          final double imageSizeInMegabytes = imageSize / 1024.0;
          if (imageSizeInMegabytes > 5) {
            setState(() {
              imageStr = '';
            });
          } else {
            setState(() {
              imageSizeInKilobytess = imageSize;

              imageStr = base64Encode(f);
            });
          }
        }
      }
    } else {
      // User canceled image selection, remove image data
      setState(() {
        imageStr = '';
      });
    }

    return imageStr!;
  }

  void _scrollListener() {
    if (_autoScrollController.offset >= 150) {
      // Cambia 200 a la cantidad de desplazamiento que desees
      setState(() {
        showButton = true;
      });
    } else {
      setState(() {
        showButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    //! -----------------------------------
    //! PROVIDER Categorias
    //! -----------------------------------
    //! PROVIDER TEMA
    final theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    final backgroundColor = theme.colorScheme.background;
    final textColor = theme.textTheme.bodyLarge!.color;
    isLoading = postsAll.isNotEmpty ? false : true;

    return Scaffold(
      floatingActionButton: showButton
          ? FloatingActionButton(
              backgroundColor: textColor,
              onPressed: () {
                _autoScrollController.animateTo(
                  0.0, // Posición a la que deseas desplazarte (inicio de la lista)
                  duration: const Duration(milliseconds: 500), // Duración de la animación
                  curve: Curves.easeInOut, // Curva de animación
                );
                setState(() {});
              },
              child: Icon(FontAwesomeIcons.arrowUp, color: backgroundColor),
            )
          : null,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      endDrawer: buildEndDrawer(context, isDarkTheme),
      drawerScrimColor: Colors.transparent, // Hace que el scrim del Drawer sea transparente
      appBar: null,
      drawer: buildDrawer(context, isDarkTheme),
      key: _scaffoldKey,
      body: CustomScrollView(
        controller: _autoScrollController,
        slivers: <Widget>[
          //! SLIVER APP BAR Drawer - Nombre de usuario - Carrito
          SliverAppBar(
            backgroundColor: backgroundColor,
            shadowColor: Colors.transparent,
            forceElevated: false,
            actions: const [SizedBox(height: 0, width: 0)],
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            expandedHeight: 70,
            pinned: true,
            floating: false,
            elevation: 0,
            title: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! DRAWER
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                icon: const Icon(Icons.menu));
                          },
                        ),
                      ),
                      //! NOMBRE USUARIO
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${myUser?.username ?? ''}\n',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold, color: textColor),
                              ),
                              TextSpan(
                                text: '¿A quién quieres quemar... 😈',
                                style: TextStyle(
                                    fontSize: 15, color: textColor, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //! CARRITO
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer(); // Abre el EndDrawer
                          },
                          icon: const Icon(FontAwesomeIcons.user),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]),
          ),
          //! SLIVER BUSCADOR  ESCROLLABLE
          SliverToBoxAdapter(
            child: Container(
              color: backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(left: 19, bottom: 10, right: 19, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${resp.width}x${resp.height}', style: const TextStyle(fontSize: 12)),
                      ResponsiveGridRow(
                        children: <ResponsiveGridCol>[
                          ResponsiveGridCol(
                            lg: 7,
                            xs: 9,
                            child: SizedBox(
                              height: 50,
                              width: resp.widthPercent(30),
                              child: MyTextFormField(
                                label: 'Buscar',
                                maxLength: 25,
                                fontSize: 14,
                                fontSizeLabel: 14,
                                paddingBotton: 0,
                                borderCircularSize: 10,
                                borderWrap: true,
                                backColor: backgroundColor,
                                underLineColor: Colors.grey,
                                counterText: false,
                                textEditingController: findControllerActividades,
                                showUnderLine: false,
                                suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass,
                                    color: Colors.grey),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (text) {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          ResponsiveGridCol(
                            lg: 1,
                            xs: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Container(
                                height: 48.5,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5), // Color de la sombra
                                      spreadRadius: 2, // Extensión de la sombra
                                      blurRadius: 5, // Desenfoque de la sombra
                                      offset:
                                          const Offset(0, 3), // Desplazamiento de la sombra (x, y)
                                    ),
                                  ],
                                ),
                                child: TextButton.icon(
                                  icon: const Icon(
                                    FontAwesomeIcons.pen,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  onPressed: () async {
                                    calendarTapped(context, resp, () {
                                      Navigator.of(context).pop();
                                      initData();
                                    });

                                    // String? respuestaImage = await pickImageWeb();
                                    // if (respuestaImage.isNotEmpty) {
                                    //   setState(() {});
                                    // }
                                  },
                                  label: const Text(
                                    "Post",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          // //! SLIVER APP BAR FILTROS FIJOS
          // SliverAppBar(
          //     expandedHeight: 59,
          //     scrolledUnderElevation: 0,
          //     backgroundColor: backgroundColor,
          //     actions: const [SizedBox(height: 0, width: 0)],
          //     iconTheme: const IconThemeData(color: Colors.black),
          //     pinned: true,
          //     floating: false,
          //     automaticallyImplyLeading: false,
          //     shadowColor: textColor,
          //     elevation: 0,
          //     title: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       //? tittedBox temporal ver su comportamiento
          //       child: FittedBox(
          //         fit: BoxFit.fill,
          //         alignment: Alignment.center,
          //         clipBehavior: Clip.none,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //             FittedBox(
          //               fit: BoxFit.fill,
          //               child: Card(
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(30),
          //                 ),
          //                 elevation: 3,
          //                 child: Container(
          //                   width: 50,
          //                   height: 50,
          //                   decoration: BoxDecoration(
          //                     color: textColor,
          //                     borderRadius: BorderRadius.circular(10),
          //                   ),
          //                   child: Icon(FontAwesomeIcons.arrowUpZA, color: backgroundColor),
          //                 ),
          //               ),
          //             ),
          //             FilterCard(
          //               backgraundColor: textColor,
          //               colorText: backgroundColor,
          //               title: 'Precio',
          //               icon: Icons.attach_money,
          //               onTap: () {
          //                 // Acción al seleccionar el filtro de precio
          //               },
          //             ),
          //             FilterCard(
          //               backgraundColor: textColor,
          //               colorText: backgroundColor,
          //               title: 'Fecha',
          //               icon: Icons.calendar_today,
          //               onTap: () {
          //                 // Acción al seleccionar el filtro de fecha
          //               },
          //             ),
          //             FilterCard(
          //               backgraundColor: textColor,
          //               colorText: backgroundColor,
          //               title: 'Ubicación',
          //               icon: Icons.location_on,
          //               onTap: () {
          //                 // Acción al seleccionar el filtro de ubicación
          //               },
          //             ),
          //             FilterCard(
          //               backgraundColor: textColor,
          //               colorText: backgroundColor,
          //               title: 'Categoría',
          //               icon: Icons.category,
          //               onTap: () {
          //                 // Acción al seleccionar el filtro de categoría
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     )),
          //! SLIVER  CATEGORIAS Y PRODUCTOS
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: backgroundColor,
                child: Column(
                  children: [
                    //!  TITLE CATEGORIAS
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' P U B L I C A D O S',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //!CARD CATEGORIAS
                    // SizedBox(
                    //   height: resp.width <= 600 ? 80 : 160,
                    //   child: isLoading
                    //       ? ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: 5,
                    //           itemBuilder: (context, index) {
                    //             return Padding(
                    //               padding: const EdgeInsets.only(left: 30, right: 5),
                    //               child: MyCategoryCard(
                    //                 skeleton: isLoading,
                    //                 label: "",
                    //                 backColor: backgroundColor,
                    //                 textColor: textColor,
                    //                 width: 300,
                    //                 height: 250,
                    //                 onPressed: () {},
                    //                 image: const Icon(Icons.abc),
                    //                 widthScreen: resp.width,
                    //               ),
                    //             );
                    //           },
                    //         )
                    //       : ListView.builder(
                    //           scrollDirection: Axis.horizontal,
                    //           itemCount: categories.length,
                    //           itemBuilder: (context, index) {
                    //             final category = categories[index];
                    //             return Padding(
                    //               padding: const EdgeInsets.only(left: 30, right: 5),
                    //               child: MyCategoryCard(
                    //                 skeleton: isLoading,
                    //                 label: category.name!,
                    //                 backColor: backgroundColor,
                    //                 textColor: textColor,
                    //                 width: 300,
                    //                 height: 250,
                    //                 onPressed: () {},
                    //                 image: const Icon(Icons.abc),
                    //                 widthScreen: resp.width,
                    //               ),
                    //             );
                    //           },
                    //         ),
                    // ),

                    //! PRODUCTOS
                    //! CircularProgressIndicator -> HAY QUE REMPLAZAR POR EL SKELETON

                    resp.width > 1350
                        ? isLoading
                            ? SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    10,
                                    (rowIndex) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          MediaQuery.of(context).size.width >= 1350 ? 4 : 3,
                                          (columnIndex) {
                                            final index = rowIndex *
                                                    (MediaQuery.of(context).size.width >= 1350
                                                        ? 4
                                                        : 3) +
                                                columnIndex;
                                            if (index < 10) {
                                              return SizedBox(
                                                width: MediaQuery.of(context).size.width /
                                                    (MediaQuery.of(context).size.width >= 1350
                                                        ? 4
                                                        : 3),
                                                height: 500,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15, right: 5, top: 15),
                                                  child: SizedBox(
                                                    width: 380,
                                                    height: 400,
                                                    child: MyProductCard(
                                                      comentarios: const [],
                                                      onPressed: (value) {
                                                        // Navegar a ProductScreen
                                                        Navigator.pushNamed(context, '/product');
                                                      },
                                                      skeleton: isLoading,
                                                      isCarrito: false,
                                                      description: '',
                                                      price: "${12.00}",
                                                      url: '',
                                                      image:
                                                          null, // Usa la URL de la imagen del producto
                                                      label: "",
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox(); // Devuelve un contenedor vacío si el índice está fuera de rango
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                    (postsAll.length /
                                            (MediaQuery.of(context).size.width >= 1350 ? 4 : 3))
                                        .ceil(),
                                    (rowIndex) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          MediaQuery.of(context).size.width >= 1350 ? 4 : 3,
                                          (columnIndex) {
                                            final index = rowIndex *
                                                    (MediaQuery.of(context).size.width >= 1350
                                                        ? 4
                                                        : 3) +
                                                columnIndex;
                                            if (index < postsAll.length) {
                                              final product = postsAll[index];
                                              return SizedBox(
                                                width: MediaQuery.of(context).size.width /
                                                    (MediaQuery.of(context).size.width >= 1350
                                                        ? 4
                                                        : 3),
                                                height: 500,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15, right: 5, top: 15),
                                                  child: SizedBox(
                                                    width: 380,
                                                    height: 400,
                                                    child: MyProductCard(
                                                      id: product.id,
                                                      comentarios: product.comments,
                                                      onPressed: (value) {
                                                        product.comments!.add(value);
                                                        // Navegar a ProductScreen
                                                        Navigator.pushNamed(context, '/product');
                                                      },
                                                      skeleton: isLoading,
                                                      isCarrito: false,
                                                      description: product.title,
                                                      price: "${12.00}",
                                                      url: product.image_url,
                                                      image:
                                                          null, // Usa la URL de la imagen del producto
                                                      label: product.content,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox(); // Devuelve un contenedor vacío si el índice está fuera de rango
                                            }
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                        : resp.width > 1350
                            ? isLoading
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: List.generate(
                                        10,
                                        (index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15, right: 5, top: 15),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: 180,
                                              child: MyProductCardMobil(
                                                  skeleton: isLoading,
                                                  isCarrito: false,
                                                  description: '',
                                                  price: "${12.00}",
                                                  url: '',
                                                  onPressed: () {
                                                    // Navegar a ProductScreen
                                                    Navigator.pushNamed(context, '/product');
                                                  },
                                                  image:
                                                      null, // Usa la URL de la imagen del producto
                                                  label: ""),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: List.generate(
                                        postsAll.length,
                                        (index) {
                                          final product = postsAll[index];
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15, right: 5, top: 15),
                                            child: SizedBox(
                                              width: 380,
                                              height: 400,
                                              child: MyProductCard(
                                                id: product.id,
                                                comentarios: product.comments,
                                                onPressed: (value) {
                                                  product.comments!.add(value);

                                                  // Navegar a ProductScreen
                                                  Navigator.pushNamed(context, '/product');
                                                },
                                                skeleton: isLoading,
                                                isCarrito: false,
                                                description: product.title,
                                                price: "${12.00}",
                                                url: product.image_url == null
                                                    ? ''
                                                    : product.image_url,

                                                image: null, // Usa la URL de la imagen del producto
                                                label: product.content,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                            : isLoading //! Resolucion para Tablets
                                ? CardMovilProductLoading(isLoading: isLoading)
                                : CardNovilProduct(products: postsAll, isLoading: isLoading),

                    const SizedBox(height: 20),
                    //! FOOTER
                    Visibility(
                      visible: kIsWeb,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            height: 125,
                            width: resp.width,
                            child: Text("", style: TextStyle(color: textColor)),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//!------------------------------------------------------------------------------------------------
//! BUILD-DRAWER
  Widget buildDrawer(
    BuildContext context,
    bool isDarkTheme,
  ) {
    double sizeIcon = 25;
    double sizeText = 16;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkTheme
                ? [Colors.black87, Colors.black54]
                : [Colors.grey, Colors.grey.withOpacity(0.2)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Q U E M A D O S   M I D',
                        style: TextStyle(
                          color: isDarkTheme ? Colors.white : Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 9, top: 9),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      //ListTile(
                      //   leading: const Icon(
                      //     FontAwesomeIcons.house,
                      //   ),
                      //   title: const Text(' Home '),
                      //   onTap: () {
                      //     // Acción al seleccionar el elemento del Drawer
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      // ListTile(
                      //   leading: const Icon(
                      //     FontAwesomeIcons.bagShopping,
                      //   ),
                      //   title: const Text(' Productos '),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => const ProductsScreen()),
                      //     );
                      //     // Cambiar tema
                      //   },
                      // ),
                      // ListTile(
                      //   hoverColor: Colors.cyan,
                      //   leading: const Icon(
                      //     FontAwesomeIcons.tags,
                      //   ),
                      //   title: const Text(' Categorias '),
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                      //     );
                      //   },
                      // ),
                      // ExpansionTile(
                      //   leading: const Icon(
                      //     FontAwesomeIcons.buildingUser,
                      //   ),
                      //   title: const Text('Organizaciones'),
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 15),
                      //       child: ListTile(
                      //         title: const Text('Ver Organizaciones'),
                      //         onTap: () {
                      //           Navigator.pop(context);
                      //           Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => const OrganizationsScreen()),
                      //           );

                      //           // Acción cuando se toca la opción 1
                      //         },
                      //       ),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 15),
                      //       child: ListTile(
                      //         title: const Text('Mi Organización'),
                      //         onTap: () {
                      //           // Acción cuando se toca la opción 2
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 190, 190, 190), width: 2.5)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text("Configuración",
                                style: TextStyle(
                                  color: isDarkTheme ? Colors.white : Colors.black,
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          !isDarkTheme ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                          color: isDarkTheme ? Colors.white : Colors.black,
                        ),
                        title: Text(
                          isDarkTheme ? ' Modo claro ' : ' Modo oscuro ',
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.8, // Ajusta este valor para cambiar el tamaño del switch
                          child: Switch(
                            value: isDarkTheme,
                            onChanged: (value) {
                              final themeChanger =
                                  Provider.of<ThemeChanger>(context, listen: false);
                              themeChanger.isDarkMode = value;
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        onTap: () {
                          final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
                          themeChanger.isDarkMode = !themeChanger.isDarkMode;
                        },
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 190, 190, 190), width: 2.5)),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Container(
            //     height: 130,
            //     padding: const EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //       border:
            //           const Border(bottom: BorderSide(color: Color.fromARGB(255, 151, 151, 151))),
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Container(
            //               width: 35,
            //               height: 35,
            //               child: CircularPercentIndicator(
            //                 radius: 16.0,
            //                 lineWidth: 3.0,
            //                 percent: 0.5,
            //                 center: const Text("50%",
            //                     style: TextStyle(fontSize: 10.0, color: Colors.black)),
            //                 progressColor: Colors.orange, // Color de progreso naranja
            //               ),
            //             ),
            //             const Icon(FontAwesomeIcons.xmark, color: Colors.black, size: 15),
            //           ],
            //         ),
            //         const SizedBox(height: 5),
            //         Row(
            //           children: [
            //             RichText(
            //                 text: const TextSpan(
            //               children: [
            //                 TextSpan(
            //                   text: 'Acompleta tu perfil\n',
            //                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //                 ),
            //                 TextSpan(
            //                   text: 'Completa tu perfil para terminar',
            //                   style:
            //                       TextStyle(fontSize: 12, color: Color.fromARGB(255, 66, 66, 66)),
            //                 ),
            //               ],
            //             )),
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 4),
            //           child: Container(
            //             width: 200,
            //             height: 30, // Ajusta el ancho según sea necesario
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10), // Bordes cuadrados
            //               gradient: LinearGradient(
            //                 colors: [Colors.orange.shade400, Colors.orange.shade800],
            //                 begin: Alignment.centerLeft,
            //                 end: Alignment.centerRight,
            //               ),
            //             ),
            //             child: TextButton(
            //               onPressed: () {
            //                 // Acción al presionar el botón
            //               },
            //               child: const Text(
            //                 "Editar Perfil",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDarkTheme
                        ? [const Color.fromARGB(221, 39, 39, 39), Colors.black54]
                        : [Colors.grey, Colors.grey.withOpacity(0.2)],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.abc,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                        text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bienvenido\n',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Abel Balam',
                          style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 66, 66, 66)),
                        ),
                      ],
                    )),
                    const Spacer(),
                    Icon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.red.shade400,
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

//!------------------------------------------------------------------------------------------------
//! BUILD-DRAWER
  Widget buildEndDrawer(
    BuildContext context,
    bool isDarkTheme,
  ) {
    double sizeIcon = 25;
    double sizeText = 16;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkTheme
                ? [Colors.black87, Colors.black54]
                : [Colors.grey, Colors.grey.withOpacity(0.2)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Mi Perfil',
                        style: TextStyle(
                          color: isDarkTheme ? Colors.white : Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 9, top: 9),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text("En Construcion...")
                  // Card(
                  //   margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  //   child: Column(children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 5),
                  //       child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  //         const SizedBox(width: 15),
                  //         Container(
                  //           width: 50,
                  //           height: 50,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(50),
                  //             color: Colors.orange,
                  //           ),
                  //           child: ClipRRect(
                  //             borderRadius: BorderRadius.circular(50),
                  //             child: Image.network(
                  //               'data:image/png;base64,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',
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //         const SizedBox(width: 20),
                  //         RichText(
                  //             text: const TextSpan(
                  //           children: [
                  //             TextSpan(
                  //               text: 'Organizacion \n',
                  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  //             ),
                  //             TextSpan(
                  //               text: '24/12/2024 : 12:00 PM',
                  //               style:
                  //                   TextStyle(fontSize: 12, color: Color.fromARGB(255, 66, 66, 66)),
                  //             ),
                  //           ],
                  //         )),
                  //       ]),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     const Row(children: [
                  //       SizedBox(width: 30),
                  //       Icon(FontAwesomeIcons.locationDot, color: Colors.blue, size: 15),
                  //       SizedBox(width: 10),
                  //       Text("Edificio C, Aula 112", style: TextStyle(fontSize: 14)),
                  //     ]),
                  //     const Padding(
                  //       padding: EdgeInsets.only(left: 23),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           RotatedBox(
                  //             quarterTurns:
                  //                 3, // Este valor rota el texto 270 grados en sentido contrario a las agujas del reloj
                  //             child: Text(
                  //               ".....",
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //                 letterSpacing: 0.2,
                  //                 color: Colors.grey,
                  //               ),
                  //               textAlign: TextAlign.left,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     const Row(children: [
                  //       SizedBox(width: 30),
                  //       Icon(FontAwesomeIcons.mapPin, color: Colors.grey, size: 15),
                  //       SizedBox(width: 10),
                  //       Text("Edificio C, Aula 112", style: TextStyle(fontSize: 14)),
                  //     ]),
                  //     const Padding(
                  //       padding: EdgeInsets.only(left: 15, right: 20, top: 5),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text("Cangreburguer",
                  //               style: TextStyle(fontSize: 12, color: Colors.black)),
                  //           Text("\$${12.05}",
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold)),
                  //         ],
                  //       ),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.only(left: 15, right: 20, top: 5),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text("Cangreburguer",
                  //               style: TextStyle(fontSize: 12, color: Colors.black)),
                  //           Text("\$${12.05}",
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold)),
                  //         ],
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       child: Divider(thickness: 1, color: Colors.grey[300]),
                  //     ),
                  //     const Padding(
                  //       padding: EdgeInsets.only(left: 15, right: 20, top: 5),
                  //       child: Row(
                  //         children: [
                  //           Text("Total", style: TextStyle(fontSize: 12, color: Colors.black)),
                  //           Spacer(),
                  //           Text("\$${12.05}",
                  //               style: TextStyle(
                  //                   fontSize: 12,
                  //                   color: Colors.black,
                  //                   fontWeight: FontWeight.bold)),
                  //         ],
                  //       ),
                  //     )
                  //   ]),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calendarTapped(BuildContext context, Responsive resp, [final void Function()? onPressed]) {
    TextEditingController textEditingController = TextEditingController();
    TextEditingController textEditingController2 = TextEditingController();
    String imageUrl = "";
    bool mustBePortrait = resp.width < 650;
    double dialogWidth = mustBePortrait ? resp.widthPercent(80) : resp.widthPercent(50);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 0,
              title: Container(
                height: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 10), // Espacio a la izquierda
                    const Text(
                      "Título del diálogo",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop(); // Botón para cerrar el diálogo
                        },
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                width: dialogWidth,
                height: mustBePortrait ? resp.heightPercent(85) : resp.heightPercent(75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 35),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        child: MyTextFormField(
                          label: 'Título',
                          textEditingController: textEditingController,
                          backColor: Colors.white,
                          fontSize: mustBePortrait ? 13 : 15,
                          borderWrap: false,
                          showUnderLine: false,
                          underLineColor: Colors.grey,
                          fontSizeLabel: mustBePortrait ? 12 : 14,
                          borderCircularSize: 5,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'El título es requerido';
                            }
                            return null;
                          },
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        child: MyTextFormField(
                          label: 'Descripción',
                          textEditingController: textEditingController2,
                          backColor: Colors.white,
                          fontSize: mustBePortrait ? 13 : 15,
                          borderWrap: false,
                          showUnderLine: false,
                          underLineColor: Colors.grey,
                          fontSizeLabel: mustBePortrait ? 12 : 14,
                          borderCircularSize: 5,
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text!.trim().isEmpty) {
                              return 'La descripción es requerida';
                            }
                            return null;
                          },
                          onChanged: (text) {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: 250,
                      height: 250,
                      child: Center(
                        child: imageUrl != "" && imageUrl != null
                            ? Stack(
                                children: [
                                  Center(
                                    child: Image.memory(
                                      Uint8List.fromList(base64Decode(imageUrl)),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: const Icon(FontAwesomeIcons.x, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          imageUrl = "";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : IconButton(
                                icon: const Icon(Icons.add_photo_alternate,
                                    size: 50, color: Colors.grey),
                                onPressed: () async {
                                  String? respuestaImage = await pickImageWeb();
                                  if (respuestaImage != null) {
                                    setState(() {
                                      imageUrl = respuestaImage;
                                    });
                                  }
                                  // Lógica para subir imagen
                                },
                              ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 11, bottom: 8),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              border: Border.all(color: Colors.blue.shade900),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton.icon(
                              icon: const Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                                size: 15,
                              ),
                              onPressed: () async {
                                DefaultStructHttpResponse response = await PostController.create(
                                  textEditingController.text,
                                  textEditingController2.text,
                                  imageUrl,
                                );

                                if (response.statusCode == 200 || response.statusCode == 201) {
                                  onPressed?.call();
                                }
                              },
                              label: const Text(
                                "Publicar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CardMovilProductLoading extends StatelessWidget {
  const CardMovilProductLoading({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          10,
          (index) {
            return Column(
              children: [
                // Aquí colocas el contenido que quieres repetir 10 veces
                Row(
                  children: List.generate(
                    MediaQuery.of(context).size.width >= 760 ? 2 : 1,
                    (columnIndex) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 180,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            right: 5,
                            top: 15,
                          ),
                          child: MyProductCardMobil(
                            skeleton: isLoading,
                            isCarrito: false,
                            description: '',
                            price: "${12.00}",
                            url: '',
                            onPressed: () {
                              Navigator.pushNamed(context, '/product');
                            },
                            image: null,
                            label: '',
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Puedes agregar espacio entre los elementos si es necesario
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CardNovilProduct extends StatelessWidget {
  const CardNovilProduct({
    super.key,
    required this.products,
    required this.isLoading,
  });

  final List<PostModel> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            (products.length / 2)
                .ceil(), // Dividir el número total de elementos entre 2 para obtener la cantidad de filas
            (rowIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  MediaQuery.of(context).size.width >= 760
                      ? 2
                      : 1, // Verificar el ancho de la pantalla
                  (columnIndex) {
                    final index = rowIndex * 2 + columnIndex;
                    if (index < products.length) {
                      // Verificar si el índice es válido
                      final product = products[index];
                      return SizedBox(
                          width: MediaQuery.of(context).size.width >= 760
                              ? MediaQuery.of(context).size.width / 2.5
                              : MediaQuery.of(context).size.width / 1.1,
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 5, top: 15),
                            child: SizedBox(
                              width: 500,
                              height: 400,
                              child: MyProductCard(
                                id: product.id,
                                comentarios: product.comments,
                                onPressed: (value) {
                                  product.comments!.add(value);
                                  // Navegar a ProductScreen
                                  Navigator.pushNamed(context, '/product');
                                },
                                skeleton: isLoading,
                                isCarrito: false,
                                description: product.title,
                                price: "${12.00}",
                                url: product.image_url == null ? '' : product.image_url,

                                image: null, // Usa la URL de la imagen del producto
                                label: product.content,
                              ),
                            ),
                          ));
                    } else {
                      return const SizedBox(); // Devuelve un contenedor vacío si el índice está fuera de rango
                    }
                  },
                ),
              );
            },
          ),
        ));
  }
}
