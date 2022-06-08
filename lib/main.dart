import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/responsive/responsive_layout.dart';
import 'package:social_media_app/utils/colors.dart';
import 'package:social_media_app/views/home.dart';
import 'package:social_media_app/views/login.dart';
import 'package:social_media_app/views/pageview.dart';
import 'package:social_media_app/views/profile.dart';
import 'package:social_media_app/widgets/authenticate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(backgroundColor: mobileBackgroundColor),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return PageScreen();
            } else if (snapshot.hasError) {
              return (Center(
                child: Text('There was an error, please reload the app'),
              ));
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return (CircularProgressIndicator(
              color: Colors.black,
            ));
          }
          return LoginPage();
        },
      ),
    );
  }
}
