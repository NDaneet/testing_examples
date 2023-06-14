import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class UserDAO extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return auth.currentUser != null;
  }

 /* String? userId() {
    return auth.currentUser?.uid;
  }*/

  String? email() {
    return auth.currentUser?.email;
  }

  Future<String?> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'weak-password') {
        log('The passwotrd is too weak');
      } else if (exception.code == 'email-already-in-use') {
        log('This account already exists for that email');
      }
      return exception.message;
    } catch (exception) {
      log(
        exception.toString(),
      );
      return exception.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'weak-password') {
        log('The passwotrd is too weak');
      } else if (exception.code == 'email-already-in-use') {
        log('This account already exists for that email');
      }
      return exception.message;
    } catch (exception) {
      log(
        exception.toString(),
      );
      return exception.toString();
    }
  }

 void logout() async{
  await auth.signOut();
  notifyListeners();
 } 
}
