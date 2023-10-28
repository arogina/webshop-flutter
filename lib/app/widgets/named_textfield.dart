import 'package:flutter/material.dart';

class NamedTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPassword;
  const NamedTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.focusNode,
    this.isPassword = false,
  });

  @override
  State<NamedTextField> createState() => _NamedTextFieldState();
}

class _NamedTextFieldState extends State<NamedTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(widget.text),
        ),
        Expanded(
            child: TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white24)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white54)),
            isDense: true,
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
          obscureText: widget.isPassword,
        ))
      ],
    );
  }
}
