import 'package:flutter/material.dart';
class MyFilterCardProduct extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final VoidCallback onTap;
  final Color? backgraundColor;
  final Color? colorText;
  final bool? isActive;

  const MyFilterCardProduct({
    super.key,
    this.title = "",
    this.icon,
    required this.onTap,
    this.backgraundColor = Colors.white,
    this.colorText = Colors.black,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: isActive! ? 2 : 0.3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isActive! ? backgraundColor : Colors.transparent,
              ),
              height: 40,
              width: 100,
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: isActive! ? Colors.orange : Colors.transparent,
                      ),
                      child: icon),
                  const SizedBox(width: 3),
                  Text(title ?? "",
                      style: TextStyle(color: isActive! ? colorText : backgraundColor)),
                ],
              ))),
    );
  }
}
