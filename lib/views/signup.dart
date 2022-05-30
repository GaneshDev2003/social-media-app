import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/views/login.dart';
import 'package:social_media_app/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;

  const SignUpPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                TextFieldInput(
                    textEditingController: _emailEditingController,
                    textInputType: TextInputType.emailAddress,
                    hintText: "E-mail Address"),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                  textEditingController: _passwordEditingController,
                  textInputType: TextInputType.visiblePassword,
                  hintText: "Password",
                  isPass: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  email =
                                      _emailEditingController.text.toString(),
                                  password = _passwordEditingController.text
                                      .toString(),
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password)
                                      .then((value) => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(
                                                            toggleView: widget
                                                                .toggleView)))
                                          })
                                      .onError((error, stackTrace) => {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          title: const Text(
                                                              'Log in Error'),
                                                          content: Text(
                                                              error.toString()),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed:
                                                                    () => {
                                                                          Navigator.of(context)
                                                                              .pop()
                                                                        },
                                                                child:
                                                                    Text('OK'))
                                                          ],
                                                        ))
                                          })
                                }
                            },
                        child: const Text("Register"))
                  ],
                ),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
