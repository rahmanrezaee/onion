import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onion/models/FirebaseUser.dart';
import 'package:onion/statemanagment/ChatManagement/HelperFunctions.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Future signInWithCustomToken(String email, String password) async {
    try {
      // UserCredential result = await _auth.signInWithCustomToken(customToken);
      // print("Mahdi: result $result");

      // FirebaseUser firebaseUser = result.user;
      // return true;

      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      HelperFunctions.saveUserNameSharedPereference(email);

      FirebaseUser firebaseUser = result.user;
      print("Mahdi: signInWithCustomToken result: $result");
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print("Firebase signInWithEmailAndPassword ${e.toString()}");
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await HelperFunctions.saveUserNameSharedPereference(email);

      print("Mahdi: signUpWithEmailAndPassword Result $result");
      FirebaseUser firebaseUser = result.user;
      // final FirebaseUser firebaseUser = (await _auth.signInWithEmailAndPassword(result)).user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print("Firebase signUpWithEmailAndPassword ${e.toString()}");
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Firebase resetPass ${e.toString()}");
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print("Firebase signOut ${e.toString()}");
    }
  }
}
