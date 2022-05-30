// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBAsEebd27ISWvM-kWibj_CCL6pbtMhsUQ',
    appId: '1:278667699311:web:bd35d83a886ef4854e199a',
    messagingSenderId: '278667699311',
    projectId: 'social-media-app-38edf',
    authDomain: 'social-media-app-38edf.firebaseapp.com',
    storageBucket: 'social-media-app-38edf.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdhHkduv2-ttFbLbAaYMRub73ZTUo-f5M',
    appId: '1:278667699311:android:e643f290a43751414e199a',
    messagingSenderId: '278667699311',
    projectId: 'social-media-app-38edf',
    storageBucket: 'social-media-app-38edf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-MWS96t1dVo_Og3xowelze5uK9570zrA',
    appId: '1:278667699311:ios:f01f893456362f274e199a',
    messagingSenderId: '278667699311',
    projectId: 'social-media-app-38edf',
    storageBucket: 'social-media-app-38edf.appspot.com',
    iosClientId: '278667699311-ie09au8qfr4uu4r2r6pgs3lghkv7ea98.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-MWS96t1dVo_Og3xowelze5uK9570zrA',
    appId: '1:278667699311:ios:f01f893456362f274e199a',
    messagingSenderId: '278667699311',
    projectId: 'social-media-app-38edf',
    storageBucket: 'social-media-app-38edf.appspot.com',
    iosClientId: '278667699311-ie09au8qfr4uu4r2r6pgs3lghkv7ea98.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMediaApp',
  );
}
