import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/OnBoarding/user_registration_view.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/root.dart';

/// Google Signin Service
class GoogleAuth {
  /// Get User's Authentication instance
  AuthController authController = Get.put(AuthController());

  /// logs in the user by Google Signin service
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authUser =
          await authController.auth.signInWithCredential(credential);

      if(authUser.user != null) {
        final id = (authUser.user?.uid)??'';

        if(id.isNotEmpty) {
          final _user = await FirebaseFutures().getUserInFirestoreInstance(id);
          if(!_user.exists){
            unawaited(Get.off(UserRegistrationView()));
          } else {
            unawaited(Get.off(const Root()));
          }
        }
      } else {
        unawaited(Get.off(UserRegistrationView()));
      }
    } catch (e) {
      Get.snackbar('Error signing in with goole account', e.toString());
    }
  }
}
