import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

Future<userModel.User> signInWithFacebook() async {
  // userModel.User u = new userModel.User();
  // Trigger the sign-in flow
  // await Firebase.initializeApp();

  // by default the login method has the next permissions ['email','public_profile']
  // AccessToken accessToken = await FacebookAuth.instance.login();
  // print(accessToken.toJson());
  // get the user data
  // final auserDatasd = await FacebookAuth.instance.getUserData();
  // print(auserDatasdz);
  // u.name = auserDatasd['']

  // return u;
}
