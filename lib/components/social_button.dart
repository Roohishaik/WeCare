import 'package:flutter/material.dart';
import 'package:wecare/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    Key? key,
    required this.social,
  }) : super(key: key);

  final String social;

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the main screen or the desired screen after successful sign-in
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        // Handle the case when userCredential.user is null
        // Display an error message or take appropriate action
      }
    } catch (e) {
      print('Failed to sign in with Google: $e');
      // Handle the sign-in error
      // Display an error message or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        side: const BorderSide(width: 1.01, color: Colors.black),
      ),
      onPressed: () {
        if (social == 'google') {
          _signInWithGoogle(context);
        } else if (social == 'facebook') {
          // Implement Facebook sign-in here
        }
      },
      child: SizedBox(
        width: Config.screenWidth! * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/$social.png',
              width: 40,
              height: 40,
            ),
            Text(
              social.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
