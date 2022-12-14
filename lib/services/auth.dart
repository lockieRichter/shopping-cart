import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_list/screens/user_info.dart';

class Auth {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  final AuthProviderManager authProviderManager;

  Auth({
    required this.googleSignIn,
    required this.firebaseAuth,
    this.authProviderManager = const AuthProviderManager(),
  });

  Future<User?> signInWithGoogle() async {
    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = authProviderManager
          .getGoogleAuthCredential(googleSignInAuthentication);

      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   customSnackBar(
          //     content: 'The account already exists with a different credential',
          //   ),
          // );
        } else if (e.code == 'invalid-credential') {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   customSnackBar(
          //     content: 'Error occurred while accessing credentials. Try again.',
          //   ),
          // );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   customSnackBar(
        //     content: 'Error occurred using Google Sign In. Try again.',
        //   ),
        // );
      }
    }

    return user;
  }

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await firebaseAuth.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
    required Auth auth,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            auth: auth,
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }
}

class AuthProviderManager {
  const AuthProviderManager();

  AuthCredential getGoogleAuthCredential(
      GoogleSignInAuthentication authentication) {
    return GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
  }
}
