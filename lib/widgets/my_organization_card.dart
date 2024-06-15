import 'package:flutter/material.dart';
import 'package:blog_app/widgets/my_text_class.dart';

class MyOrganizationCard extends StatelessWidget {
  final void Function() onPressed;
  final String? title;
  final String? description;
  final String? image;
  final bool isCarrito;

  const MyOrganizationCard({
    super.key,
    required this.onPressed,
    required this.image,
    required this.title,
    required this.description,
    this.isCarrito = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 250,
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen a la izquierda
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover, // Opcional: ajusta la imagen dentro del contenedor
                  ),
                ),
                const SizedBox(width: 5),
                MyTextClass(text: title!, fontSize: 20, isTextColor: true, wrap: false),
              ],
            ),
            const SizedBox(width: 10), // Espacio entre la imagen y la información

            // Información y botón
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Texto de la tarjeta
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: ' DESCRIPCION\n',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
