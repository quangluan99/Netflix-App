import 'package:flutter/material.dart';

class NfilledButton extends StatelessWidget {
  final String text;
  final void Function()? onPress;
  final bool right;
  final IconData icon;
  final Size size;
  final TextTheme textTheme;
  const NfilledButton(
      {super.key,
      required this.text,
      required this.textTheme,
      required this.size,
      required this.right,
      required this.icon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: right ? size.height * 0.034 : size.height * 0.05,
              vertical: 12),
        ),
        onPressed: onPress,
        label: Text(
          text,
          style: textTheme.bodyLarge!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        icon: Icon(
          icon,
          color: Colors.black,
          size: 25,
        ));
  }
}
