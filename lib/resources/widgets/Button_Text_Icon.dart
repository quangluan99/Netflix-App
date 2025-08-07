import 'package:flutter/material.dart';

class ButtonTextIcon extends StatelessWidget {
  final TextTheme textTheme;
  final IconData icon;
  final void Function()? onTap;
  final Color colorText;
  final Color colorBackground;
  final String title;
  const ButtonTextIcon(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title,
      required this.textTheme,
      required this.colorText,
      required this.colorBackground});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 18.0),
        decoration: BoxDecoration(
            color: colorBackground, borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: colorText,
            ),
            Text(
              title,
              style: textTheme.bodyLarge!.copyWith(color: colorText),
            )
          ],
        ),
      ),
    );
  }
}
