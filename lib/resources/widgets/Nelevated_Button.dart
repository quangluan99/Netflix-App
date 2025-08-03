import 'package:flutter/material.dart';

class NTextButton extends StatelessWidget {
  final void Function()? onPress;
  IconData? keyboardArrowDown;
  final String text;

  final TextTheme textTheme;
  NTextButton(
      {super.key,
      this.keyboardArrowDown,
      required this.onPress,
      required this.text,
      required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return keyboardArrowDown == null
        ? TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white54)),
              backgroundColor: Colors.black,
            ),
            onPressed: onPress,
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          )
        : TextButton.icon(
            iconAlignment: IconAlignment.end,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white54)),
              backgroundColor: Colors.black,
            ),
            onPressed: onPress,
            icon: Icon(
              keyboardArrowDown,
              color: Colors.white,
            ),
            label: Text(
              textAlign: TextAlign.center,
              text,
              style: textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          );
  }
}
