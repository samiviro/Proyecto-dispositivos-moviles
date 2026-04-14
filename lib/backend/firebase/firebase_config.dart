import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCCuZLaYXTf8xCifHtrAaqfkH8MA8P_b3A",
            authDomain: "fide-ea10c.firebaseapp.com",
            projectId: "fide-ea10c",
            storageBucket: "fide-ea10c.firebasestorage.app",
            messagingSenderId: "693296645908",
            appId: "1:693296645908:web:b8ae7ef13feb58e399e401",
            measurementId: "G-V8CN09M5P8"));
  } else {
    await Firebase.initializeApp();
  }
}
