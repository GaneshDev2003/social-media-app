import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/views/login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData(String uid) async {
    final snap = await _firestore.collection('users').doc(uid).get();
    return (snap.data() as Map<String, dynamic>);
  }

  Future registerWithEmailAndPassword(
      UserModel user, BuildContext context, File file) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('ProfilePics')
          .child(user.username);
      await ref.putFile(file);
      String profilePicURL = await ref.getDownloadURL();
      await _firestore.collection("users").doc(cred.user!.uid).set({
        'username': user.username,
        'bio': user.bio,
        'email': user.email,
        'profilePicURL': profilePicURL,
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Log in Error'),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      child: Text('OK'))
                ],
              ));
      print(error.toString());
      return null;
    }
  }
}
