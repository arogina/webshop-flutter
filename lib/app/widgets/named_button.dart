import 'package:flutter/material.dart';

class NamedButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  const NamedButton({
    super.key,
    required this.text,
    required this.onClick,
  });

  @override
  State<NamedButton> createState() => _NamedButtonState();
}

class _NamedButtonState extends State<NamedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      child: Text(widget.text),
    );
  }
}
