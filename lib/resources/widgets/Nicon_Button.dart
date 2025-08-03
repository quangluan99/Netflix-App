import 'package:flutter/material.dart';

class NIconButton extends StatelessWidget {
  final void Function()? onPress;
  final IconData icon;
  const NIconButton({super.key, this.onPress, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      

    );
  }
}
