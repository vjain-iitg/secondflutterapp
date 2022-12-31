import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDHeW85QLzTG9HVr_ynbFTCAAv4Bd2N-kE',
    appId: '1:903875909600:web:aeb357ebaa5f08136e3d85',
    messagingSenderId: '903875909600',
    projectId: 'movies-app-481b6',
    authDomain: 'movies-app-481b6.firebaseapp.com',
    storageBucket: 'movies-app-481b6.appspot.com',
    measurementId: 'G-V59DYDYM9S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVORlHbOO04l5EASjjc4t5qxlbzD5e8uY',
    appId: '1:903875909600:android:4df7d6ac6e9270696e3d85',
    messagingSenderId: '903875909600',
    projectId: 'movies-app-481b6',
    storageBucket: 'movies-app-481b6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDV1E08GJfjK4adbDA3r9Z7kNImAOCKtHM',
    appId: '1:903875909600:ios:28bfe34065fd7feb6e3d85',
    messagingSenderId: '903875909600',
    projectId: 'movies-app-481b6',
    storageBucket: 'movies-app-481b6.appspot.com',
    iosClientId:
        '903875909600-9qq8smbj1dfpekmev4c6hevsbkcu6bmj.apps.googleusercontent.com',
    iosBundleId: 'com.example.assign3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDV1E08GJfjK4adbDA3r9Z7kNImAOCKtHM',
    appId: '1:903875909600:ios:28bfe34065fd7feb6e3d85',
    messagingSenderId: '903875909600',
    projectId: 'movies-app-481b6',
    storageBucket: 'movies-app-481b6.appspot.com',
    iosClientId:
        '903875909600-9qq8smbj1dfpekmev4c6hevsbkcu6bmj.apps.googleusercontent.com',
    iosBundleId: 'com.example.assign3',
  );
}
