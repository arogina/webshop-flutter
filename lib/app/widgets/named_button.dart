import 'package:flutter/material.dart';

class NamedButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color backgroundColor;
  final double? fontSize;
  const NamedButton({
    super.key,
    required this.text,
    required this.onClick,
    this.backgroundColor = Colors.brown,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => backgroundColor)),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize ?? 20),
          ),
        ));
  }
}
