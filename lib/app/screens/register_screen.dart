import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/api/users/users.dart';
import 'package:webshop_flutter/app/widgets/named_button.dart';
import 'package:webshop_flutter/app/widgets/named_textfield.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;

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

  final _formKey = GlobalKey<FormState>();

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _repeatPasswordController.text) {
        final api = UsersApi(global.dio);
        final user = User(
            username: _userNameController.text,
            password: _passwordController.text,
            createdAt: DateTime.now());

        try {
          await api.createUser(user);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "User created!",
              ),
              showCloseIcon: true,
            ));
          }

          _formKey.currentState!.reset();
          _userNameFocus.requestFocus();
        } on Exception catch (ex) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(ex.toString()),
            ));
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password should match repeated password!"),
          ));
        }
      }
    }
  }

  void _setFocus() {
    if (_userNameController.text == "") {
      _userNameFocus.requestFocus();
    } else {
      if (_passwordController.text == "") {
        _passwordFocus.requestFocus();
      } else {
        if (_repeatPasswordController.text == "") {
          _repeatPasswordFocus.requestFocus();
        }
      }
    }
  }

  @override
  void initState() {
    _setFocus();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _userNameFocus.dispose();
    _passwordFocus.dispose();
    _repeatPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
        child: Scaffold(
          appBar: AppBar(
              title: const Row(
            children: [
              Icon(Icons.shopping_basket, size: 30),
              SizedBox(width: 10),
              Text("WebShop"),
            ],
          )),
          body: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.fontSize,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    NamedTextField(
                      text: "Username:",
                      controller: _userNameController,
                      focusNode: _userNameFocus,
                      onSubmit: (value) => {_setFocus()},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    NamedTextField(
                      text: "Password:",
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      isPassword: true,
                      onSubmit: (value) => {_setFocus()},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    NamedTextField(
                      text: "Repeat password:",
                      controller: _repeatPasswordController,
                      focusNode: _repeatPasswordFocus,
                      isPassword: true,
                      onSubmit: (value) => {_setFocus()},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    NamedButton(
                      text: 'Register',
                      onClick: _registerUser,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => {},
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        ));
  }
}
