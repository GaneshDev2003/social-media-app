import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/views/login.dart';
import 'package:social_media_app/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/services/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  //final UserModel user = UserModel(email: "", password: "", username: "");

  AuthService auth = AuthService();
  String email = '';
  String password = '';
  String username = '';
  String bio = '';
  File? profilePic;
  String profilePicURL = '';
  UserModel user =
      UserModel(email: '', password: '', username: '', bio: '', profilePic: '');
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    profilePic != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                MemoryImage(profilePic!.readAsBytesSync()),
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          icon: Icon(Icons.upload),
                          onPressed: () async {
                            XFile? file;
                            ImagePicker picker = ImagePicker();

                            file = await picker.pickImage(
                                source: ImageSource.camera);
                            setState(() {
                              profilePic = File(file!.path);
                            });
                          },
                        ))
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                TextFieldInput(
                    textEditingController: _usernameController,
                    hintText: "Userna",
                    textInputType: TextInputType.name),
                const SizedBox(
                  height: 20,
                ),
                TextFieldInput(
                    textEditingController: _emailEditingController,
                    textInputType: TextInputType.emailAddress,
                    hintText: "Email Address"),
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
                TextFieldInput(
                    textEditingController: _bioController,
                    hintText: 'Something about yourself....',
                    textInputType: TextInputType.multiline),
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
                                  username =
                                      _usernameController.text.toString(),
                                  email =
                                      _emailEditingController.text.toString(),
                                  password = _passwordEditingController.text
                                      .toString(),
                                  bio = _bioController.text.toString(),
                                  user = UserModel(
                                      profilePic: profilePicURL,
                                      email: email,
                                      password: password,
                                      username: username,
                                      bio: bio),
                                  if (profilePic != null)
                                    {
                                      auth.registerWithEmailAndPassword(
                                          user, context, profilePic!),
                                    }
                                  else
                                    {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'Empty Profile Pic'),
                                                content: const Text(
                                                    'Please choose a profile pic'),
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
                                    }
                                }
                            },
                        child: const Text("Register"))
                  ],
                ),
                // Flexible(
                //   flex: 2,
                //   child: Container(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
