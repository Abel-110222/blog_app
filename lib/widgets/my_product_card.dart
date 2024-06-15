// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:typed_data';

import 'package:blog_app/controllers/post_controller.dart';
import 'package:blog_app/models/comment_model.dart';
import 'package:blog_app/utils/default_struct_http_response.dart';
import 'package:blog_app/widgets/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyProductCard extends StatefulWidget {
  final bool skeleton;
  final String id;
  final String label;
  final String description;
  final String price;
  final List<CommentModel>? comentarios;

  final void Function(CommentModel value) onPressed;
  final Widget? image;
  final String url;
  final Color backColor;
  final bool isCarrito;

  MyProductCard({
    super.key,
    this.skeleton = true,
    this.id = '',
    this.label = '',
    this.description = '',
    this.price = '',
    required this.comentarios,
    required this.onPressed,
    required this.image,
    required this.url,
    this.backColor = Colors.white,
    this.isCarrito = false,
  });

  @override
  State<MyProductCard> createState() => _MyProductCardState();
}

class _MyProductCardState extends State<MyProductCard> {
  TextEditingController comentarioController = TextEditingController();
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Image.memory(
            Uint8List.fromList(base64Decode(imageUrl)),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backColor = theme.cardColor;
    final textColor = theme.textTheme.bodyLarge!.color;

    return Card(
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen en la parte superior
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: widget.url.isEmpty
                ? Container(
                    height: 150, // El 50% del alto de la tarjeta
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  )
                : MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _showImageDialog(context, widget.url),
                      child: Container(
                        height: 160, // El 50% del alto de la tarjeta
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Image.memory(
                          Uint8List.fromList(base64Decode(widget.url)),
                          fit: BoxFit.scaleDown,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Texto de la tarjeta
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: widget.backColor,
                        ),
                      ),
                      Text(
                        widget.label,
                        maxLines: 2, // Número máximo de líneas permitidas
                        overflow: TextOverflow.ellipsis, // Manejo del desbordamiento de texto
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 142, 140, 140),
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

                      // Precio
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Comentarios (${widget.comentarios!.length})",
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          Divider(color: Colors.grey),
          // Action Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                backColor: widget.backColor,
                icon: Icons.thumb_up_alt_outlined,
                label: 'Me gusta',
              ),
              ActionButton(
                backColor: widget.backColor,
                icon: Icons.comment_outlined,
                label: 'Comentar',
              ),
              ActionButton(
                backColor: widget.backColor,
                icon: Icons.share,
                label: 'Compartir',
              ),
            ],
          ),
          Container(
            height: 60, // Ajusta la altura según sea necesario
            child: widget.comentarios != null && widget.comentarios!.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.comentarios!.length,
                    itemBuilder: (context, index) {
                      final comentario = widget.comentarios![index];
                      return Row(children: [
                        Icon(Icons.comment, color: Colors.grey, size: 13),
                        SizedBox(width: 10),
                        Text(
                          comentario.content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ]);
                    },
                  )
                : Center(
                    child: Text(
                    'No hay comentarios',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )),
          ),
          SizedBox(
            height: 35,
            width: 230,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: MyTextFormField(
                label: 'Comentar',
                maxLength: 25,
                fontSize: 13,
                fontSizeLabel: 14,
                paddingBotton: 10,
                borderCircularSize: 10,
                borderWrap: true,
                backColor: backColor,
                underLineColor: Colors.grey,
                counterText: false,
                textEditingController: comentarioController,
                showUnderLine: false,
                suffixIcon: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.grey,
                    size: 13,
                  ),
                  onPressed: () async {
                    if (comentarioController.text.isNotEmpty) {
                      DefaultStructHttpResponse response = await PostController.createComment(
                        widget.id,
                        comentarioController.text,
                      );

                      if (response.statusCode == 200 || response.statusCode == 201) {}
                      setState(() {});
                      print(widget.comentarios!.length);
                    }
                  },
                ),
                validator: (value) {
                  return null;
                },
                onChanged: (text) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backColor;

  ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    this.backColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: TextButton.icon(
          onPressed: () {},
          icon: Icon(icon, color: backColor),
          label: Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
