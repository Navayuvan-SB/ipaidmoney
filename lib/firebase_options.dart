// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyC6aRKj8o-97FCYYGHTJrnjnreROcEzoDI',
    appId: '1:196820754064:web:c1e9b58af21f6dbeb74215',
    messagingSenderId: '196820754064',
    projectId: 'ipaidmoney-ff6b4',
    authDomain: 'ipaidmoney-ff6b4.firebaseapp.com',
    storageBucket: 'ipaidmoney-ff6b4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPXuiSpIDGIHuUTqV1c5ogvjOItZm2UHA',
    appId: '1:196820754064:android:2583fa00c2f5f24db74215',
    messagingSenderId: '196820754064',
    projectId: 'ipaidmoney-ff6b4',
    storageBucket: 'ipaidmoney-ff6b4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmxXge8P9ZitsK_tMdq7iXjYsre9GeZOE',
    appId: '1:196820754064:ios:d90ad51f1afd2c1fb74215',
    messagingSenderId: '196820754064',
    projectId: 'ipaidmoney-ff6b4',
    storageBucket: 'ipaidmoney-ff6b4.appspot.com',
    iosBundleId: 'com.ipaidmoney.ipaidmoney',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmxXge8P9ZitsK_tMdq7iXjYsre9GeZOE',
    appId: '1:196820754064:ios:d90ad51f1afd2c1fb74215',
    messagingSenderId: '196820754064',
    projectId: 'ipaidmoney-ff6b4',
    storageBucket: 'ipaidmoney-ff6b4.appspot.com',
    iosBundleId: 'com.ipaidmoney.ipaidmoney',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC6aRKj8o-97FCYYGHTJrnjnreROcEzoDI',
    appId: '1:196820754064:web:c92ab2881e285d28b74215',
    messagingSenderId: '196820754064',
    projectId: 'ipaidmoney-ff6b4',
    authDomain: 'ipaidmoney-ff6b4.firebaseapp.com',
    storageBucket: 'ipaidmoney-ff6b4.appspot.com',
  );
}
