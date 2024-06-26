import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  const Responsive({super.key, required this.child, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? 600,
        ),
        child: child,
      ),
    );
  }
}
