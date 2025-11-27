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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBnEhUoRjHsTBj-urxWdUebof0z-XkaoC0',
    appId: '1:302338549188:web:61b615e922324a7b523091',
    messagingSenderId: '302338549188',
    projectId: 'freud-app-9ea9f',
    authDomain: 'freud-app-9ea9f.firebaseapp.com',
    storageBucket: 'freud-app-9ea9f.firebasestorage.app',
    measurementId: 'G-1929181R77',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfJREiVLg8ZhGLaC5N13fGFEwT1Qg_sn0',
    appId: '1:302338549188:android:3cb1d13e2511179d523091',
    messagingSenderId: '302338549188',
    projectId: 'freud-app-9ea9f',
    storageBucket: 'freud-app-9ea9f.firebasestorage.app',
  );
}
