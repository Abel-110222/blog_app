// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';
// import 'package:blog_app/Pages/categories_screen.dart';
// import 'package:blog_app/Pages/organizations_screen.dart';
// import 'package:blog_app/Pages/products_screen.dart';
// import 'package:blog_app/bloc/theme.dart';
// import 'package:blog_app/models/category/categories_model.dart';
// import 'package:blog_app/utils/responsive.dart';
// import 'package:blog_app/widgets/my_category_card.dart';
// import 'package:blog_app/widgets/my_product_card.dart';
// import 'package:blog_app/widgets/my_text_form_field.dart';
// import 'package:responsive_grid/responsive_grid.dart';

// class HomeWeb extends StatefulWidget {
//   static String routeName = 'View_Home_web';
//   const HomeWeb({
//     super.key,
//   });

//   @override
//   State<HomeWeb> createState() => _HomeWebState();
// }

// class _HomeWebState extends State<HomeWeb> {
//   //!-------------------------------
//   //! Variables
//   bool isLoading = false;
//   bool showCard = true;
//   bool showWriter = false;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   ///
//   ///!  *************************************************************
//   ///!  GLOBALS KEYS
//   ///!  *************************************************************
//   ///
//   //* GENERALES
//   GlobalKey keyRespuesta = GlobalKey();

//   ///!  *************************************************************
//   ///!  TEXTE EDITING CONTROLLERS
//   ///!  *************************************************************

//   //*BUSCADOR SECUNDARIO
//   TextEditingController respuestaController = TextEditingController();
//   TextEditingController findControllerActividades = TextEditingController();

//   ///
//   ///!  *************************************************************
//   ///!  FOCUS NODE
//   ///!  *************************************************************
//   ///
//   ///
//   ///FocusNode bloqueoEditarFocusNode = FocusNode();
//   FocusNode respuestaFocusNode = FocusNode();

//   //!-------------------------------
//   //! Listas
//   int currentIndex = 0; // Asegúrate de inicializar currentIndex
//   int score = 0;
//   List<Categories> categories = []; // Variable para almacenar las categorías
//   @override
//   void initState() {
//     super.initState();
//     // loadCategories();
//   }

//   ///!  *************************************************************
//   ///!  DISPOSE
//   ///!  *************************************************************
//   @override
//   void dispose() {
//     super.dispose();
//     //general
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive resp = Responsive(context);

//     // Obtener el tema actual
//     final theme = Theme.of(context);
//     // Verificar si el tema es oscuro
//     final bool isDarkTheme = theme.brightness == Brightness.dark;

//     // Obtener los colores del tema
//     final backgroundColor = theme.colorScheme.background;
//     final textColor = theme.textTheme.bodyLarge!.color;
//     // double myWidthWork = (resp.widthPercent(100));

//     if (isLoading) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             LoadingAnimationWidget.staggeredDotsWave(
//               color: const Color.fromARGB(255, 54, 76, 244),
//               size: 30,
//             ),
//             Text("     Cargando....", style: TextStyle(fontSize: resp.fontSizeTitle)),
//           ],
//         ),
//       );
//     } else {
//       return Scaffold(
//         key: _scaffoldKey,
//         // appBar: AppBar(

//         //   toolbarHeight: 100,
//         //   title: Row(
//         //     children: [
//         //       Padding(
//         //         padding: const EdgeInsets.only(left: 5.0, top: 50),
//         //         child: RichText(
//         //           text: const TextSpan(
//         //             children: [
//         //               TextSpan(
//         //                 text: 'Hola Abel\n',
//         //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         //               ),
//         //               TextSpan(
//         //                 text: '¿Qué vas a ordenar hoy?',
//         //                 style: TextStyle(fontSize: 16, color: Colors.grey),
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ),
//         //       const Spacer(),
//         //     ],
//         //   ),
//         //   actions: const [
//         //     Padding(
//         //       padding: EdgeInsets.only(right: 10),
//         //       child: Icon(Icons.account_circle, size: 40),
//         //     ),
//         //   ],
//         // ),
//         drawer: buildDrawerWeb(context, isDarkTheme), // Agrega el Drawer aquí
//         body: isLoading
//             ? const Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(),
//                     Text("Cargando...."),
//                   ],
//                 ),
//               )
//             : ScrollConfiguration(
//                 behavior: ScrollConfiguration.of(context).copyWith(
//                   dragDevices: {
//                     PointerDeviceKind.touch,
//                     PointerDeviceKind.mouse,
//                   },
//                 ),
//                 child: GestureDetector(
//                   onTap: () {
//                     FocusScope.of(context).unfocus();
//                   },
//                   child: Container(
//                     height: resp.height,
//                     width: resp.width,
//                     // padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
//                     color: Colors.white,
//                     //decoration: BoxDecoration(border: Border.all(width: 0, color: Colors.amber)),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView(
//                             children: [
//                               Row(children: [
//                                 Container(
//                                   margin: const EdgeInsets.fromLTRB(30, 15, 0, 0),
//                                   decoration: BoxDecoration(
//                                     color: const Color.fromARGB(255, 56, 56, 56),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   width: 50,
//                                   height: 50,
//                                   child: IconButton(
//                                       onPressed: () {
//                                         _scaffoldKey.currentState?.openDrawer();
//                                       },
//                                       icon: const Icon(Icons.menu)),
//                                 )
//                               ]),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
//                                 child: RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       TextSpan(
//                                         text: 'Hola Abel\n',
//                                         style: TextStyle(
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.bold,
//                                             color: textColor),
//                                       ),
//                                       const TextSpan(
//                                         text: '¿Qué vas a ordenar hoy?',
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             color: Color.fromARGB(255, 201, 200, 200)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Column(
//                                 children: [
//                                   //! RESPONSIVE GRID ROW
//                                   ResponsiveGridRow(
//                                     children: <ResponsiveGridCol>[
//                                       //! SECCION DEL NOMBRE

//                                       //!RESPONSIVE GRID COL
//                                       ResponsiveGridCol(
//                                         lg: 6,
//                                         //md: 12,
//                                         xs: 12,
//                                         child: Container(
//                                           padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
//                                           height: 60,
//                                           width: resp.widthPercent(30),
//                                           child: MyTextFormField(
//                                             label: 'Buscar',
//                                             maxLength: 25,
//                                             fontSize: 14,
//                                             fontSizeLabel: 14,
//                                             paddingBotton: 12,
//                                             borderCircularSize: 10,
//                                             borderWrap: true,
//                                             backColor: backgroundColor,
//                                             underLineColor: Colors.grey,
//                                             counterText: false,
//                                             textEditingController: findControllerActividades,
//                                             showUnderLine: false,
//                                             suffixIcon: const Icon(FontAwesomeIcons.magnifyingGlass,
//                                                 color: Colors.grey),
//                                             validator: (value) {
//                                               return null;
//                                             },
//                                             onChanged: (text) {
//                                               //String str = text.trim().toUpperCase();

//                                               setState(() {});
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 20),
//                                   Align(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 30, right: 30),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'CATEGORIAS',
//                                             style: TextStyle(
//                                               fontSize: 20, // Tamaño de fuente del título
//                                               fontWeight:
//                                                   FontWeight.bold, // Peso de la fuente del título
//                                               color: textColor, // Color del texto del título
//                                             ),
//                                           ),
//                                           // Container(
//                                           //   height: 1,
//                                           //   width: double.infinity,
//                                           //   color: Colors.orange[700],
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),

//                                   SizedBox(
//                                     height: resp.width <= 600 ? 80 : 160,
//                                     child: ListView.builder(
//                                       scrollDirection:
//                                           Axis.horizontal, // Para desplazamiento horizontal
//                                       itemCount: 4, // Se repetirá 6 veces
//                                       itemBuilder: (context, index) {
//                                         return Padding(
//                                           padding: const EdgeInsets.only(left: 30, right: 5),
//                                           child: MyCategoryCard(
//                                             backColor: textColor,
//                                             textColor: backgroundColor,
//                                             width: 300,
//                                             height: 250,
//                                             onPressed: () {},
//                                             image: const Icon(Icons.abc),
//                                             widthScreen: resp.width,
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),

//                                   // SizedBox(
//                                   //   height: 160,
//                                   //   child: Padding(
//                                   //       padding: const EdgeInsets.symmetric(
//                                   //           horizontal:
//                                   //               10), // Ajusta el padding según sea necesario
//                                   //       child: ListView.builder(
//                                   //         scrollDirection: Axis.horizontal,
//                                   //         itemCount: categories.length,
//                                   //         itemBuilder: (context, index) {
//                                   //           return MyCategoryCard(
//                                   //             label: categories[index].name,
//                                   //             widthScreen: resp.width,
//                                   //             onPressed: () {},
//                                   //             image: Icon(Icons.abc),
//                                   //           );
//                                   //         },
//                                   //       )),
//                                   // ),

//                                   //   onPressed: () {},
//                                   //   label: 'Nombre del producto',
//                                   //   image: Image.asset('assets/Producto.png'),
//                                   // )

//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Align(
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(left: 30, right: 30),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'PRODUCTOS',
//                                             style: TextStyle(
//                                               fontSize: 20, // Tamaño de fuente del título
//                                               fontWeight:
//                                                   FontWeight.bold, // Peso de la fuente del título
//                                               color: textColor, // Color del texto del título
//                                             ),
//                                           ),
//                                           // Container(
//                                           //   height: 1,
//                                           //   width: double.infinity,
//                                           //   color: Colors.orange[700],
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 235,
//                                     child: Center(
//                                       child: ListView.builder(
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: 8,
//                                         itemBuilder: (context, index) {
//                                           return Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 15, right: 5, top: 15),
//                                             child: MyProductCard(
//                                               onPressed: () {},
//                                               image: Image.asset('assets/hamburger-and-fries.jpg'),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 235,
//                                     child: Center(
//                                       child: ListView.builder(
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: 4,
//                                         itemBuilder: (context, index) {
//                                           return Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 15, right: 5, top: 15),
//                                             child: MyProductCard(
//                                               onPressed: () {},
//                                               image: Image.asset('assets/hamburger-and-fries.jpg'),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),

//                                   // ListView.builder(
//                                   //   scrollDirection: Axis.vertical,
//                                   //   itemCount: 10,
//                                   //   itemBuilder: (context, index) {
//                                   //     return Padding(
//                                   //       padding:
//                                   //           const EdgeInsets.only(left: 15, right: 5, top: 15),
//                                   //       child: MyProductCardMobil(
//                                   //         onPressed: () {},
//                                   //         image: Image.asset('assets/hamburger-and-fries.jpg'),
//                                   //       ),
//                                   //     );
//                                   //   },
//                                   // )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       );
//     }
//   }

//   Widget buildDrawerWeb(BuildContext context, bool isDarkTheme) {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: isDarkTheme
//                 ? [Colors.black87, Colors.black54]
//                 : [Colors.grey, Colors.grey.withOpacity(0.2)],
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   width: 100,
//                   height: 100,
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/logo.png'),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'M E T I N G   P O I N T',
//                   style: TextStyle(
//                     color: isDarkTheme ? Colors.white : Colors.black,
//                     fontSize: 22,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30, right: 30, bottom: 9, top: 9),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             ListTile(
//               leading: const Icon(
//                 FontAwesomeIcons.house,
//               ),
//               title: const Text(' Home '),
//               onTap: () {
//                 // Acción al seleccionar el elemento del Drawer
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 FontAwesomeIcons.bagShopping,
//               ),
//               title: const Text(' Productos '),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ProductsScreen()),
//                 );
//                 // Cambiar tema
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 FontAwesomeIcons.tags,
//               ),
//               title: const Text(' Categorias '),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const CategoriesScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 FontAwesomeIcons.buildingUser,
//               ),
//               title: const Text(' Organizaciones '),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const OrganizationsScreen()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 !isDarkTheme ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
//                 color: isDarkTheme ? Colors.white : Colors.black,
//               ),
//               title: Text(
//                 isDarkTheme ? ' Modo claro ' : ' Modo oscuro ',
//                 style: TextStyle(
//                   color: isDarkTheme ? Colors.white : Colors.black,
//                 ),
//               ),
//               trailing: Transform.scale(
//                 scale: 0.8, // Ajusta este valor para cambiar el tamaño del switch
//                 child: Switch(
//                   value: isDarkTheme,
//                   onChanged: (value) {
//                     final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
//                     themeChanger.isDarkMode = value;
//                   },
//                   activeColor: Colors.white,
//                   activeTrackColor: Colors.white.withOpacity(0.5),
//                 ),
//               ),
//               onTap: () {
//                 final themeChanger = Provider.of<ThemeChanger>(context, listen: false);
//                 themeChanger.isDarkMode = !themeChanger.isDarkMode;
//               },
//             ),

//             // Agrega más elementos del Drawer según sea necesario
//           ],
//         ),
//       ),
//     );
//   }
// }
