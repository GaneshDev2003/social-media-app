import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = '';
  String bio = '';
  String email = '';
  String profilePic = '';
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      email = (snap.data() as Map<String, dynamic>)['email'];
      bio = (snap.data() as Map<String, dynamic>)['bio'];
      username = (snap.data() as Map<String, dynamic>)['username'];
      profilePic = (snap.data() as Map<String, dynamic>)['profilePicURL'];
    });

    print('******** $username *******');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: username == ''
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(height: size.height * 0.15),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                      backgroundImage: NetworkImage(profilePic),
                      radius: MediaQuery.of(context).size.width * 0.35),
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 2.5,
                ),
                Text(
                  username,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
                Text(bio),
              ]));
  }
}
