import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyProductCardMobil extends StatefulWidget {
  final bool skeleton;
  final String label;
  final String description;
  final String price;

  final void Function() onPressed;
  final Widget? image;
  final String url;
  final Color backColor;
  final bool isCarrito;

  const MyProductCardMobil({
    this.skeleton = true,
    this.label = '',
    this.description = '',
    this.price = '',
    required this.onPressed,
    required this.image,
    required this.url,
    this.backColor = Colors.white,
    this.isCarrito = false,
    super.key,
  });

  @override
  State<MyProductCardMobil> createState() => _MyProductCardMobilState();
}

class _MyProductCardMobilState extends State<MyProductCardMobil> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge!.color;

    return Card(
      child: Skeletonizer(
        containersColor: Colors.grey,
        enabled: widget.skeleton,
        child: Container(
          width: 300,
          height: 500,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.backColor,
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen a la izquierda
                  widget.skeleton
                      ? Container(
                          width: 130, // Ancho de la imagen
                          height: 150, // Alto de la tarjeta
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 130, // Ancho de la imagen
                          height: 150, // Alto de la tarjeta
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.url),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                        ),
                  const SizedBox(width: 10), // Espacio entre la imagen y la información

                  // Información y botón
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        // Texto de la tarjeta
                        Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4), // Espacio entre las dos líneas de texto
                        Text(
                          widget.description,
                          maxLines: 2, // Número máximo de líneas permitidas
                          overflow: TextOverflow.ellipsis, // Manejo del desbordamiento de texto
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 201, 200, 200),
                          ),
                        ),
                        // RichText(
                        //   text: TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: label,
                        //         style: TextStyle(
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.black,
                        //         ),
                        //       ),
                        //       TextSpan(
                        //         text: "\n$description",
                        //         style: TextStyle(
                        //           fontSize: 12,
                        //           color: Color.fromARGB(255, 201, 200, 200),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(height: 5), // Espacio entre el texto y el precio

                        // Precio
                        Text(
                          !widget.isCarrito ? widget.price : "",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5), // Espacio entre el precio y el botón
                      ],
                    ),
                  ),
                ],
              ),
              const Positioned(
                right: 8,
                child: Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Row(
                  children: [
                    InkWell(
                      onTap: widget.onPressed,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: const Center(
                          child: Text("Ver detalles",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.orange,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Colors.orange,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class MyProductCardMobil extends StatelessWidget {
//   final String label;
//   final void Function() onPressed;
//   final Widget? image;
//   final Color backColor;
//   final bool isCarrito;

//   const MyProductCardMobil({
//     super.key,
//     this.label = '',
//     required this.onPressed,
//     required this.image,
//     this.backColor = Colors.white,
//     this.isCarrito = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final backColor = theme.cardColor;
//     final textColor = theme.textTheme.bodyLarge!.color;

//     return Card(
//       child: Container(
//         width: 300,
//         height: 180,
//         padding: const EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Colors.white,
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Imagen a la izquierda
//             Container(
//               width: 130, // Ancho de la imagen
//               height: 150, // Alto de la tarjeta
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage("assets/hamburger-and-fries.jpg"),
//                 ),
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                     topRight: Radius.circular(10),
//                     bottomRight: Radius.circular(10)),
//               ),
//             ),
//             const SizedBox(width: 10), // Espacio entre la imagen y la información

//             // Información y botón
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Texto de la tarjeta
//                   RichText(
//                     text: const TextSpan(
//                       children: [
//                         TextSpan(
//                           text: ' Cangreburger\n',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         TextSpan(
//                           text: 'cangreburger con queso',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Color.fromARGB(255, 201, 200, 200),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 5), // Espacio entre el texto y el precio

//                   // Icono de favorito
//                   const Padding(
//                     padding: EdgeInsets.only(right: 5.0),
//                     child: Icon(
//                       FontAwesomeIcons.heart,
//                       color: Colors.black,
//                     ),
//                   ),

//                   // Precio
//                   Text(
//                     !isCarrito ? " \$250.00" : "",
//                     style: const TextStyle(
//                       fontSize: 15,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 5), // Espacio entre el precio y el botón
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.orange,
//                         ),
//                         child: const Icon(
//                           FontAwesomeIcons.plus,
//                           color: Colors.white,
//                           size: 15,
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Botón
//                 ],
//               ),
//             ),
//             !isCarrito
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const SizedBox(
//                         width: 50,
//                         height: 50,
//                         child: Icon(
//                           FontAwesomeIcons.heart,
//                           color: Colors.red,
//                           size: 15,
//                         ),
//                       ),
//                       Container(
//                         width: 50,
//                         height: 50,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.orange,
//                         ),
//                         child: const Icon(
//                           FontAwesomeIcons.plus,
//                           color: Colors.white,
//                           size: 15,
//                         ),
//                       ),
//                     ],
//                   )
//                 : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 20),
//                         child: Text("x2",
//                             style: TextStyle(
//                                 color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
//                       ),
//                     ],
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
