import 'package:flutter/material.dart';
import 'package:webshop_flutter/app/api/users/users.dart';
import 'package:webshop_flutter/app/responsive/responsive.dart';
import 'package:webshop_flutter/app/screens/home_screen.dart';
import 'package:webshop_flutter/app/screens/register_screen.dart';
import 'package:webshop_flutter/app/widgets/named_button.dart';
import 'package:webshop_flutter/app/widgets/named_textfield.dart';
import 'package:webshop_flutter/app/utils/globals.dart' as global;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _userNameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final api = UsersApi(global.dio);

      try {
        var user = await api.getUserByUsername(_userNameController.text);

        if (user != null && user.isNotEmpty) {
          if (user[0].password == _passwordController.text) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Successful login!"),
              ));

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            }
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Incorrect password! Try again")));
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("User don't exist! Please try again."),
            ));
          }
        }
      } on Exception catch (ex) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ex.toString()),
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
    _userNameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.brown,
              title: const Row(
                children: [
                  Icon(Icons.shopping_basket, size: 30),
                  SizedBox(width: 10),
                  Text("WebShop"),
                ],
              )),
          body: Responsive(
              child: Container(
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
                          "Log In",
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
                    const SizedBox(
                      height: 15,
                    ),
                    NamedButton(
                      text: 'Log In',
                      onClick: _login,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () => {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()))
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          )),
        ));
  }
}
