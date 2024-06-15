import 'package:blog_app/widgets/my_decimal_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormFieldKF extends StatelessWidget {
  /// Texto que se visualiza antes de que se teclee algun caracter en el control
  final String label;

  /// Tamaño del texto
  final double fontSizeLabel;

  /// Tamaño de la fuente
  final double fontSize;

  /// Ancho, en pixeles, del control
  final double width;

  /// Maximo de caracteres que se pueden capturar en el control.
  /// Cuando se especifica una cantidad en la parte inferior derecha se muestra
  /// un contador de los caracteres tecleados y la cantidad restante de
  /// caracteres que faltan para llegar al limite.
  final int? maxLength;

  /// Icono que se visualiza a un costado derecho del control a modo de identificacion
  /// y sentido donde se emplea dicho control
  final Widget? suffixIcon;

  /// Icono que se visualiza a un costado derecho del control a modo de identificacion
  /// y sentido donde se emplea dicho control
  //final Widget? suffixIcon;

  final int? maxLines;
  final double topControl;
  final double paddingTop;

  /// Color de fondo del control
  final Color? backColor;

  /// Propiedad para controlar el contenido del control.
  final TextEditingController textEditingController;

  /// Especifica el tipo de teclado que si visualizar al momento de que el control
  /// obtenga el foco. El efecto de esta propiedad solo se visualiza cuando la
  /// app se ejecuta en un dispositivo movil
  final TextInputType keyboardType;

  final bool readOnly;

  final Color textColor;

  final FocusNode? focusNode;

  final bool onlyDigits;
  final bool isSignMoney;

  /// Determina los caracteres permitidos para su captura. Si su valor es true
  /// (por default es false) el control solo permite la captura de numeros,
  /// punto decimal y signo menos.
  final bool onlyNumber;

  final bool onlyPhoneNumber;

  /// Muestra u oculta el texto que se esta escribiendo
  final bool obscureText;

  final bool? counterText;

  final TextCapitalization textCapitalization;
  final double rowHeight;

  /// Evento para validar el dato introducido (segun lo que se defina)
  final String? Function(String? text) validator;

  /// Funcion de parametro que ejecuta cada vez que cambia el valor del texto
  final void Function(String text) onChanged;

  final void Function(String text)? onFieldSubmitted;

  final void Function()? onTap;
  final void Function()? onEditingComplete;
  //
  const MyTextFormFieldKF({
    super.key,
    this.label = '',
    this.fontSizeLabel = 20,
    this.fontSize = 18,
    this.width = 200,
    this.maxLength,
    this.suffixIcon,
    this.maxLines,
    this.topControl = 13,
    this.paddingTop = 5,
    this.backColor = Colors.white,
    this.textColor = const Color(0xFF9E9E9E),
    //this.suffixIcon,
    required this.textEditingController,
    this.keyboardType = TextInputType.name,
    this.onlyDigits = false,
    this.isSignMoney = false,
    this.onlyNumber = false,
    this.onlyPhoneNumber = false,
    this.readOnly = false,
    this.focusNode,
    this.obscureText = false,
    this.counterText = true,
    this.textCapitalization = TextCapitalization.none,
    this.rowHeight = 90,
    required this.validator,
    required this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        color: backColor,
      ),
      child: Container(
        padding: EdgeInsets.only(top: topControl),
        child: TextFormField(
          controller: textEditingController,
          textCapitalization: textCapitalization,
          readOnly: readOnly,
          focusNode: focusNode,
          maxLength: maxLength,
          maxLines: maxLines,
          expands: false,
          decoration: InputDecoration(
            //alignLabelWithHint: true,
            prefix: const SizedBox(),
            prefixStyle: const TextStyle(fontSize: 5),
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,

            //suffixIcon: suffixIcon,

            /// border: const OutlineInputBorder(
            ///   borderSide: BorderSide(color: Colors.red, width: 5.0),
            /// ),
            /// enabledBorder: OutlineInputBorder(
            ///   borderSide: BorderSide(color: Colors.grey[500] as Color, width: 1),
            /// ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: '',
            isCollapsed: false,
            contentPadding: EdgeInsets.fromLTRB(10, paddingTop, 0, 0),
            labelText: label == '' ? null : label,
            counterText: counterText as bool ? null : '',
            filled: false,
            labelStyle: TextStyle(
              fontSize: fontSizeLabel,
              color: readOnly ? textColor : textColor,
            ),
          ),
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: fontSize,
            color: readOnly ? textColor : Colors.white,
          ),
          inputFormatters: onlyDigits
              ? <TextInputFormatter>[
                  //FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
                  //MoneyInputFormatter(),
                  MyDecimalFormatter(decimalDigits: 0),
                  // FilteringTextInputFormatter.digitsOnly,
                  // FilteringTextInputFormatter.deny('5')
                ]
              : onlyPhoneNumber
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      //FilteringTextInputFormatter.digitsOnly,
                      //FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      //MyDecimalFormatter(decimalDigits: 2, isSignMoney: isSignMoney),
                      //CustomTextInputFormatter(),
                      // FilteringTextInputFormatter.digitsOnly,
                      // FilteringTextInputFormatter.deny('5')
                    ]
                  : onlyNumber
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.-]")),
                          MyDecimalFormatter(decimalDigits: 2, isSignMoney: isSignMoney),
                          // FilteringTextInputFormatter.digitsOnly,
                          // FilteringTextInputFormatter.deny('5')
                        ]
                      : null,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
        ),
      ),
    );
  }
}
