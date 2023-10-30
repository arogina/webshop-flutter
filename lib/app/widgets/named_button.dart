import 'package:flutter/material.dart';

class NamedButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final Color backgroundColor;
  const NamedButton(
      {super.key,
      required this.text,
      required this.onClick,
      this.backgroundColor = Colors.brown});

  @override
  State<NamedButton> createState() => _NamedButtonState();
}

class _NamedButtonState extends State<NamedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
              (states) => widget.backgroundColor)),
      child: Text(widget.text),
    );
  }
}
