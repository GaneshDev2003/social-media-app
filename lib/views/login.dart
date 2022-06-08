import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/views/home.dart';
import 'package:social_media_app/views/pageview.dart';
import 'package:social_media_app/views/signup.dart';
import 'package:social_media_app/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Welcome back!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )),
                const SizedBox(
                  height: 35,
                ),
                //Image.asset('login.png'),
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
                  height: 35,
                ),
                ElevatedButton(
                    onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              email = _emailEditingController.text.toString(),
                              password =
                                  _passwordEditingController.text.toString(),
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password)
                                  .then(
                                    (value) => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  PageScreen())))
                                    },
                                  )
                                  .onError((error, stackTrace) => {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      'Log in Error'),
                                                  content: const Text(
                                                      'There was an Error Logging in, please try again'),
                                                  actions: [
                                                    ElevatedButton(
                                                        onPressed: () => {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop()
                                                            },
                                                        child: Text('OK'))
                                                  ],
                                                ))
                                      })
                            }
                          // ignore: avoid_print
                        },
                    child: Text("Sign In")),
                Flexible(
                  flex: 2,
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Are you a new user ? "),
                    GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()))
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                Flexible(child: Container(), flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
