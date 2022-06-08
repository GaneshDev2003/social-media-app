import 'package:flutter/cupertino.dart';
import './user_model.dart';

class Post {
  final String description;
  final String postURL;
  final String uid;
  final String username;
  final String profilePic;

  Post({
    required this.description,
    required this.postURL,
    required this.uid,
    required this.username,
    required this.profilePic,
  });
}
