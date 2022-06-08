import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  CollectionReference postReference =
      FirebaseFirestore.instance.collection('posts');

  Future<void> uploadPost(String title, String description, File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef.child('Posts').child(title);
    await ref.putFile(file);
    String postURL = await ref.getDownloadURL();
    String url = "url";

    String uid = await FirebaseAuth.instance.currentUser!.uid;
    print('**********Adding post***********');
    return postReference
        .add({
          'Title': title,
          'Description': description,
          'Post URL': postURL,
          'uid': uid,
        })
        .then((value) => print("************User Added**********"))
        .catchError((error, stackTrace) => print('Failed to add user $error'));
  }
}
