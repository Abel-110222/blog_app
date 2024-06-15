// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/models/category/categories_model.dart';
import 'package:blog_app/providers/categories_provider.dart';
import 'package:blog_app/utils/responsive.dart';
import 'package:blog_app/widgets/my_category_card.dart';
import 'package:blog_app/widgets/my_filter_card_product.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  List<Categories> categories = [];

  @override
  void initState() {
    super.initState();
    //  loadcategories();
  }

  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    categoriesProvider.getCategories();
    categories = categoriesProvider.category;

    // Obtener el tema actual
    final theme = Theme.of(context);
    // Verificar si el tema es oscuro
    final bool isDarkTheme = theme.brightness == Brightness.dark;

    // Obtener los colores del tema
    final backgroundColor = theme.colorScheme.background;
    final textColor = theme.textTheme.bodyLarge!.color;
    // double myWidthWork = (resp.widthPercent(100));
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: const Color.fromARGB(255, 54, 76, 244),
              size: 30,
            ),
            Text("     Cargando....", style: TextStyle(fontSize: resp.fontSizeTitle)),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            AnimSearchBar(
              width: 300,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
              onSubmitted: (String) {},
            ),
          ],
        ),
        body: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Cargando...."),
                  ],
                ),
              )
            : ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    height: resp.height,
                    width: resp.width,
                    // padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    color: Colors.white,
                    //decoration: BoxDecoration(border: Border.all(width: 0, color: Colors.amber)),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'NUESTRAS ORGANIZACIONES\n',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      const TextSpan(
                                        text: 'Encontra tu organización favorita',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 201, 200, 200)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 15, 0, 0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                    MyFilterCardProduct(
                                      isActive: true,
                                      backgraundColor: textColor,
                                      colorText: backgroundColor,
                                      title: 'Categoría',
                                      onTap: () {
                                        // Acción al seleccionar el filtro de categoría
                                      },
                                    ),
                                    MyFilterCardProduct(
                                      backgraundColor: textColor,
                                      colorText: backgroundColor,
                                      title: 'Categoría',
                                      onTap: () {
                                        // Acción al seleccionar el filtro de categoría
                                      },
                                    ),
                                    MyFilterCardProduct(
                                      backgraundColor: textColor,
                                      colorText: backgroundColor,
                                      title: 'Categoría',
                                      onTap: () {
                                        // Acción al seleccionar el filtro de categoría
                                      },
                                    ),
                                    Card(
                                      elevation: 0.3,
                                      child: Container(
                                          width: 20,
                                          height: 20,
                                          color: Colors.transparent,
                                          child: const Icon(FontAwesomeIcons.sliders)),
                                    )
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              !isLoading
                                  ? Column(
                                      children: List.generate(
                                        (categories.length / 2)
                                            .ceil(), // Dividir el número total de elementos entre 2 para obtener la cantidad de filas
                                        (rowIndex) {
                                          return Row(
                                            children: List.generate(
                                              MediaQuery.of(context).size.width >= 760
                                                  ? 2
                                                  : 1, // Verificar el ancho de la pantalla
                                              (columnIndex) {
                                                final index = rowIndex * 2 + columnIndex;
                                                if (index < categories.length) {
                                                  // Verificar si el índice es válido
                                                  final product = categories[index];
                                                  return SizedBox(
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    height: 180,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 5, top: 15),
                                                      child: MyCategoryCard(
                                                        skeleton: isLoading,
                                                        label: product.name!,
                                                        backColor: backgroundColor,
                                                        textColor: textColor,
                                                        width: 300,
                                                        height: 250,
                                                        onPressed: () {},
                                                        image: const Icon(Icons.abc),
                                                        widthScreen: resp.width,
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
                                    )
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: categories.length,
                                      itemBuilder: (context, index) {
                                        final category = categories[index];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 30, right: 5),
                                          child: MyCategoryCard(
                                            skeleton: isLoading,
                                            label: category.name!,
                                            backColor: backgroundColor,
                                            textColor: textColor,
                                            width: 300,
                                            height: 250,
                                            onPressed: () {},
                                            image: const Icon(Icons.abc),
                                            widthScreen: resp.width,
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    }
  }
}
