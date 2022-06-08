import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/services/auth.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/views/upload.dart';
import 'package:social_media_app/models/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List postData = [];
  List<Post> posts = [];
  AuthService auth = AuthService();
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Post post = Post(
      description: '',
      username: '',
      uid: '',
      postURL: '',
      profilePic: '',
    );
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('posts').get();
    setState(() {
      postData = snap.docs.map((doc) => doc.data()).toList();
    });
    postData = snap.docs.map((doc) => doc.data()).toList();
    // print(postData.toString());
    for (var i = 0; i < postData.length; i++) {
      //print(postData[i]);

      Map<String, dynamic> snapUsers =
          await auth.getUserData(postData[i]['uid']);
      String username = snapUsers['username'];
      String profilePic = snapUsers['profilePicURL'];
      post = Post(
        description: postData[i]['Description'],
        username: username,
        uid: postData[i]['uid'],
        postURL: postData[i]['Post URL'],
        profilePic: profilePic,
      );
      setState(() {
        posts.add(post);
      });
    }
    print(posts.length);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: mobileBackgroundColor,
        appBar: AppBar(title: Text("Feed"), actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              //print(urls);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UploadPage()));
            },
          )
        ]),
        body: postData.isEmpty
            ? const Center(
                child: Text('Wow! Such Empty!'),
              )
            : ListView(
                children: [
                  for (var post in posts)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(post.profilePic),
                                      radius: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        post.username,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  width: size.width * 0.85,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(post.postURL)))),

                              SizedBox(height: 10),
                              // Image.network(
                              //   urls[i],
                              //   errorBuilder: (context, error, stackTrace) =>
                              //       Text('PURL not valid'),
                              // ),

                              SizedBox(height: 5),
                              Text(post.description)
                            ]),
                      ),
                    ),
                ],
              ));
  }
}
