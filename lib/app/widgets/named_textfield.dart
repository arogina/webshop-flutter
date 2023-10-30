import 'package:flutter/material.dart';

class NamedTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPassword;
  final bool isRequired;
  final ValueSetter? onSubmit;
  const NamedTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.focusNode,
    this.isPassword = false,
    this.isRequired = true,
    this.onSubmit,
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
          width: widget.text == "" ? null : 100,
          child: Text(widget.text),
        ),
        Expanded(
            child: TextFormField(
          cursorColor: Colors.brown,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white24)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.brown)),
            isDense: true,
          ),
          style: const TextStyle(
            color: Colors.black,
          ),
          obscureText: widget.isPassword,
          validator: (value) {
            if ((value == null || value.isEmpty) && widget.isRequired) {
              return "Required field";
            }
            return null;
          },
          onFieldSubmitted: widget.onSubmit,
        ))
      ],
    );
  }
}
