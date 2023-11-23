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
    apiKey: 'AIzaSyAxH-Ku3yhLZCqXGWAjy6cJsyWOx8BZSz0',
    appId: '1:367173214250:web:70bc4b0df28ba2e265a353',
    messagingSenderId: '367173214250',
    projectId: 'tubescc2023',
    authDomain: 'tubescc2023.firebaseapp.com',
    storageBucket: 'tubescc2023.appspot.com',
    measurementId: 'G-4QCP9VMMM2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQVN21_oYFL69Qs_kjkw9Obo2eJzAXN1s',
    appId: '1:367173214250:android:bebedc75dc05a73065a353',
    messagingSenderId: '367173214250',
    projectId: 'tubescc2023',
    storageBucket: 'tubescc2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8NF6BDSlviHPj17wcZAUSG6zW19_6a-0',
    appId: '1:367173214250:ios:84fd080cc3525cdd65a353',
    messagingSenderId: '367173214250',
    projectId: 'tubescc2023',
    storageBucket: 'tubescc2023.appspot.com',
    iosBundleId: 'com.example.smartWebapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD8NF6BDSlviHPj17wcZAUSG6zW19_6a-0',
    appId: '1:367173214250:ios:641f1ad642d45bcf65a353',
    messagingSenderId: '367173214250',
    projectId: 'tubescc2023',
    storageBucket: 'tubescc2023.appspot.com',
    iosBundleId: 'com.example.smartWebapp.RunnerTests',
  );
}