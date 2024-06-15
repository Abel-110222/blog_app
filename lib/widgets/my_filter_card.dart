import 'package:flutter/material.dart';

class FilterCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? backgraundColor;
  final Color? colorText;

  const FilterCard({
    super.key,
    this.title = "",
    required this.icon,
    required this.onTap,
    this.backgraundColor = Colors.white,
    this.colorText = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgraundColor,
              ),
              height: 40,
              width: 115,
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: colorText),
                  const SizedBox(width: 5),
                  Text(title ?? "", style: TextStyle(color: colorText)),
                ],
              ))),
    );
  }
}
