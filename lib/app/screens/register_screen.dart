import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/widgets/named_button.dart';
import 'package:webshop_flutter/app/widgets/named_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  final _userNameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _repeatPasswordFocus = FocusNode();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _userNameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: ListView(
          children: [
            NamedTextField(
              text: "Username:",
              controller: _userNameController,
              focusNode: _userNameFocus,
            ),
            const SizedBox(
              height: 15,
            ),
            NamedTextField(
              text: "Password:",
              controller: _passwordController,
              focusNode: _passwordFocus,
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            NamedTextField(
              text: "Repeat password:",
              controller: _repeatPasswordController,
              focusNode: _repeatPasswordFocus,
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            NamedButton(
              text: 'Register',
              onClick: () => {},
            )
          ],
        ),
      ),
    );
  }
}
