import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/OnBoarding/user_registration_view.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/root.dart';

class GoogleAuth {
  AuthController authController = Get.put(AuthController());
  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential authUser =
          await authController.auth.signInWithCredential(credential);

      authUser.additionalUserInfo!.isNewUser
          ? Get.off(UserRegistrationView())
          : Get.off(const Root());
    } catch (e) {
      Get.snackbar('Error signing in with goole account', e.toString());
    }
  }
}
