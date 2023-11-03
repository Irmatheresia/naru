import 'dart:ffi';
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      return user?.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> getUser() async {
    User? user = await _firebaseAuth.currentUser;
    return user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signUp(String email, String password) async {
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = authResult.user;
    return user?.uid;
  }

  Future googleLogin() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider().credential()

    }
  }
}
