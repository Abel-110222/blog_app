// ignore_for_file: use_super_parameters

import 'package:blog_app/widgets/my_decimal_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  /// Texto que se visualiza antes de que se teclee algun caracter en el control
  final String label;

  /// Tamaño del texto
  final double fontSizeLabel;

  /// Icono que se visualiza a un costado derecho del control a modo de identificacion
  /// y sentido donde se emplea dicho control
  final Widget? suffixIcon;

  /// Determina si el control tendra o no un borde alrededor de todo el control.
  /// Por default esta propiedad es true.
  final bool borderWrap;

  /// Valor del border circular. Este se aprecia cuando la propiedad
  /// "borderWrap" es true.
  final double borderCircularSize;

  /// Tamaño de la fuente
  final double fontSize;

  /// Ancho, en pixeles, del control
  final double width;

  /// Maximo de caracteres que se pueden capturar en el control.
  /// Cuando se especifica una cantidad en la parte inferior derecha se muestra
  /// un contador de los caracteres tecleados y la cantidad restante de
  /// caracteres que faltan para llegar al limite.
  final int? maxLength;
  final int maxLines;
  final bool onlyDigits;
  final double paddingTop;
  final double paddingBotton;
  final double paddingLeft;
  final double paddingRight;

  /// Color de fondo del control
  final Color? backColor;

  /// Color de la linea y borde del control
  final Color underLineColor;

  /// Muestra u oculta la linea inferior
  final bool showUnderLine;

  /// Propiedad para controlar el contenido del control.
  final TextEditingController textEditingController;

  /// Especifica el tipo de teclado que si visualizar al momento de que el control
  /// obtenga el foco. El efecto de esta propiedad solo se visualiza cuando la
  /// app se ejecuta en un dispositivo movil
  final TextInputType keyboardType;

  final bool readOnly;

  final FocusNode? focusNode;

  /// Determina los caracteres permitidos para su captura. Si su valor es true
  /// (por default es false) el control solo permite la captura de numeros,
  /// punto decimal y signo menos.
  final bool onlyNumber;

  /// Muestra u oculta el texto que se esta escribiendo
  final bool obscureText;

  final bool? counterText;

  /// Evento para validar el dato introducido (segun lo que se defina)
  final String? Function(String? text) validator;

  /// Funcion de parametro que ejecuta cada vez que cambia el valor del texto
  final void Function(String text) onChanged;

  final void Function(String text)? onFieldSubmitted;

  final void Function()? onTap;
  //
  const MyTextFormField({
    Key? key,
    this.label = '',
    this.fontSizeLabel = 20,
    this.suffixIcon,
    this.borderWrap = true,
    this.showUnderLine = true,
    this.borderCircularSize = 50,
    this.fontSize = 18,
    this.width = 200,
    this.maxLength,
    this.maxLines = 1,
    this.onlyDigits = false,
    this.paddingTop = 0,
    this.paddingBotton = 0,
    this.paddingLeft = 10,
    this.paddingRight = 5,
    this.backColor = Colors.white,
    this.underLineColor = Colors.transparent,
    required this.textEditingController,
    this.keyboardType = TextInputType.name,
    this.onlyNumber = false,
    this.readOnly = false,
    this.focusNode,
    this.obscureText = false,
    this.counterText = false,
    required this.validator,
    required this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: width,
      padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingRight, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderCircularSize),
        border: Border.all(
          width: 0,
          style: BorderStyle.solid,
          color: borderWrap ? underLineColor : Colors.transparent,
        ),
        color: backColor,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          TextFormField(
            controller: textEditingController,
            readOnly: readOnly,
            focusNode: focusNode,
            maxLines: maxLines,
            cursorColor: const Color(0xff9f9f9f),
            maxLength: maxLength,
            decoration: InputDecoration(
              border: showUnderLine ? null : InputBorder.none,
              hintText: '',
              isCollapsed: false,
              contentPadding: EdgeInsets.fromLTRB(0, paddingTop, 0, paddingBotton),
              labelText: label == '' ? null : label,
              counterText: counterText as bool ? null : '',
              labelStyle: TextStyle(
                fontSize: fontSizeLabel,
              ),
              floatingLabelStyle: const TextStyle(fontSize: 12),
              //icon: icon,
              // suffixIcon: suffixIcon,
            ),
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(
              fontSize: fontSize,
              color: readOnly ? Colors.grey[500] : Colors.black,
            ),
            inputFormatters: onlyDigits
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                    // FilteringTextInputFormatter.digitsOnly,
                    // FilteringTextInputFormatter.deny('5')
                  ]
                : onlyNumber
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.-]")),
                        MyDecimalFormatter(decimalDigits: 2),
                        // FilteringTextInputFormatter.digitsOnly,
                        // FilteringTextInputFormatter.deny('5')
                      ]
                    : null,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            onTap: onTap,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: suffixIcon,
          ),
        ],
      ),
    );
  }
}
