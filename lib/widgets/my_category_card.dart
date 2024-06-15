// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCategoryCard extends StatefulWidget {
  final bool skeleton;
  final double widthScreen;
  final String label;
  final void Function() onPressed;
  final Widget image;
  final double width;
  final double height;
  final bool isSelected;
  final Color? backColor;
  final Color? textColor;

  const MyCategoryCard({
    this.skeleton = true,
    required this.widthScreen,
    required this.onPressed,
    required this.image,
    this.width = 200,
    this.height = 150,
    this.label = '',
    this.isSelected = false,
    this.backColor = Colors.white,
    this.textColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  _MyCategoryCardState createState() => _MyCategoryCardState();
}

class _MyCategoryCardState extends State<MyCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // widthScreen para web
    if (widget.widthScreen >= 600) {
      return Skeletonizer(
        containersColor: Colors.amber,
        enabled: widget.skeleton,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: GestureDetector(
              onTap: widget.onPressed,
              child: Stack(
                children: [
                  // Imagen que cubre toda la tarjeta
                  Transform.scale(
                    scale: _isHovered ? 1.1 : 1.0,
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // image: const DecorationImage(
                        //   image: AssetImage(
                        //       "assets/restaurant-breakfast.jpg"), // Reemplazar con tu ruta de imagen
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _isHovered ? 1.1 : 1.0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 0.5,
                      child: Container(
                        width: widget.width,
                        height: widget.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Color semi-transparente encima de la imagen

                  // Texto en el centro de la tarjeta
                  Center(
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Skeletonizer(
        justifyMultiLineText: false,
        enabled: widget.skeleton,
        containersColor: Colors.grey[500],
        child: Container(
          width: 85,
          height: 100,
          decoration: BoxDecoration(
            color: widget.backColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.fastfood, color: widget.textColor),
            Text(widget.label, style: TextStyle(color: widget.textColor))
          ]),
        ),
      );
    }
  }
}
