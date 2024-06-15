// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/Pages/home.dart';
import 'package:blog_app/models/product/Product_Model.dart';
import 'package:blog_app/providers/product_provider.dart';
import 'package:blog_app/utils/responsive.dart';
import 'package:blog_app/widgets/my_filter_card_product.dart';
import 'package:blog_app/widgets/my_product_card.dart';
import 'package:blog_app/widgets/my_product_card_mobil.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isLoading = false;
  TextEditingController textController = TextEditingController();
  late List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    Responsive resp = Responsive(context);
    //! -----------------------------------
    //! PROVIDER Productos
    final productorProvider = Provider.of<ProductProvider>(context);
    productorProvider.getProducts();
    products = productorProvider.productList;

    // Obtener el tema actual
    final theme = Theme.of(context);
    // Verificar si el tema es oscuro
    // ignore: unused_local_variable
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
          surfaceTintColor: backgroundColor,
          elevation: 0,
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
                                        text: 'NUESTROS PRODUCTOS\n',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      const TextSpan(
                                        text: 'Pide tu producto ahora',
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
                              resp.width > 1350
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: List.generate(
                                          products.length,
                                          (index) {
                                            final product = products[index];
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 5, top: 15),
                                              child: SizedBox(
                                                width: 350,
                                                height: 250,
                                                child: MyProductCard(
                                                  comentarios: [],
                                                  onPressed: (value) {
                                                   

                                                    // Navegar a ProductScreen
                                                    Navigator.pushNamed(context, '/product');
                                                  },
                                                  skeleton: isLoading,
                                                  isCarrito: false,
                                                  description: product.description ?? '',
                                                  price: "${12.00}",
                                                  url: product.images![0].url ?? '',

                                                  image:
                                                      null, // Usa la URL de la imagen del producto
                                                  label: product.name!,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : resp.width < 1000
                                      ? isLoading
                                          ? SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: List.generate(
                                                  10,
                                                  (index) {
                                                    return Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 5, top: 15),
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
                                                              Navigator.pushNamed(
                                                                  context, '/product');
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
                                                  products.length,
                                                  (index) {
                                                    final product = products[index];
                                                    return Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15, right: 5, top: 15),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(context).size.width,
                                                        height: 180,
                                                        child: MyProductCardMobil(
                                                          skeleton: isLoading,
                                                          isCarrito: false,
                                                          description: product.description ?? '',
                                                          price: "${12.00}",
                                                          url: product.images![0].url ?? '',
                                                          onPressed: () {
                                                            // Navegar a ProductScreen
                                                            Navigator.pushNamed(
                                                                context, '/product');
                                                          },
                                                          image:
                                                              null, // Usa la URL de la imagen del producto
                                                          label: product.name!,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                      : isLoading //! Resolucion para Tablets
                                          ? CardMovilProductLoading(isLoading: isLoading)
                                          : CardNovilProduct(products: [], isLoading: isLoading),
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
