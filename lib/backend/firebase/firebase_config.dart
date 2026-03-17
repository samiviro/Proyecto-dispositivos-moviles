import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDAS9pWA4tc4-2VJxqDmXs_8Bg8rMEjV-A",
            authDomain: "fidelitas-redi.firebaseapp.com",
            projectId: "fidelitas-redi",
            storageBucket: "fidelitas-redi.firebasestorage.app",
            messagingSenderId: "896392051078",
            appId: "1:896392051078:web:ff8e3038eb322165d2d407",
            measurementId: "G-HZKRNEJ8FR"));
  } else {
    await Firebase.initializeApp();
  }
}
