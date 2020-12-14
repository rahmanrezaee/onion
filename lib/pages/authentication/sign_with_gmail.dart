import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onion/const/values.dart';

import 'package:onion/models/users.dart' as userModel;
import 'package:onion/statemanagment/auth_provider.dart';
import 'package:provider/provider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  String idToken = await authResult.user.getIdToken(true);

  return idToken;
}

Future<Map> signInWithFacebook() async {
  print("idToken wait");
  try {
    final AccessToken result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.token);
    print("idToken token ${result.token}");
    // Once signed in, return the UserCredential

     
   
    UserCredential authResult = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    print("idToken auth it ${result.token}");
    String idToken = await authResult.user.getIdToken(true);

    print("idToken authResult $authResult");
    print("idToken $idToken");

    return {
      "status" : true,
      "idToken" : idToken,
    };
  } catch (e, s) {

    return {
      "status" : false,
      "message" : e.message,
    };
    // print("error ${e.message}");
    // if (e is FacebookAuthException) {
    //   print(e.message);
    //   switch (e.errorCode) {
    //     case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
    //       print("idToken You have a previous login operation in progress");
    //       break;
    //     case FacebookAuthErrorCode.CANCELLED:
    //       print("idToken login cancelled");
    //       break;
    //     case FacebookAuthErrorCode.FAILED:
    //       print("idToken login failed");
    //       break;
    //   }
    // }
  }
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}
