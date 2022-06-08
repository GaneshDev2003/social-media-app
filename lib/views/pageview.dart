import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/views/home.dart';
import 'package:social_media_app/views/profile.dart';
import 'package:social_media_app/views/upload.dart';

class PageScreen extends StatelessWidget {
  const PageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      children: [
        HomePage(),
        UploadPage(),
        ProfilePage(),
      ],
    );
  }
}
