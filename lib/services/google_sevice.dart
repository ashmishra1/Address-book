/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_app/src/screens/home.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<bool> signInWithGoogle(BuildContext context) async {
  try {
    final googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      var googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      final authResult = await auth.signInWithCredential(credential);

      final user = authResult.user;

      var userData = {
        'name': googleSignInAccount.displayName,
        'provider': 'google',
        'photoUrl': googleSignInAccount.photoUrl,
        'email': googleSignInAccount.email,
      };

      await users.doc(user!.uid).get().then((doc) => {
            if (doc.exists)
              {doc.reference.update(userData)}
            else
              {
                users.doc(user.uid).set(userData),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Home(),
                ))
              }
          });
    }
  } catch (e) {
    print(e);
  }
  return true;
}*/
