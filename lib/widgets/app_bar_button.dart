import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final Widget text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style:
          ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white)),
      child: text,
    );
  }
}
