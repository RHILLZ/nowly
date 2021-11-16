// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Screens/OnBoarding/user_registration_view.dart';
import 'package:nowly/root.dart';
import 'package:sizer/sizer.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final RxString _email = RxString('');
  final RxString _password = RxString('');
  final RxString _confirmed = RxString('');

  get firebaseUser => _firebaseUser.value;
  get auth => _auth;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  void createAccount(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Get.off(UserRegistrationView());

      //CHECK ACCOUNT TYPE THEN NAVIGATE TO APPROPIATE SCREEN
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Problem creating user', e.message!,
          snackPosition: SnackPosition.BOTTOM);
    } catch (exception) {
      print(exception.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.off(const Root());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Problem signing in user', e.message!,
          snackPosition: SnackPosition.BOTTOM);
    } catch (exception) {
      print(exception.toString());
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error signing out user', e.message!,
          snackPosition: SnackPosition.BOTTOM);
    } catch (exception) {
      print(exception.toString());
    }
  }

  void deleteUserAccount() async {
    try {
      await _auth.currentUser!.delete();
    } catch (exception) {
      print(exception.toString());
    }
  }

  void reAuthenticateUserWithEmailandPassword(
      String email, String password) async {
    try {
      final cred =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(cred);
    } catch (exception) {
      print(exception.toString());
      Get.snackbar('Error reauthenticating user.', exception.toString());
    }
  }

  Future<bool> sendPasswordReset(String email) async {
    bool isSuccessful = false;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      isSuccessful = true;
    } catch (exception) {
      print(exception.toString());
      Get.snackbar('Error sending password reset', exception.toString());
    }
    return isSuccessful;
  }

  emailOption(context) {
    final onboardSelection = GetStorage().read('onboardSelection');
    Get.bottomSheet(
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  height: 70.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      gradient: authPagesGradient(context),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        onboardSelection == 'newAccount'
                            ? 'Create Account'.toUpperCase()
                            : 'Sign In'.toUpperCase(),
                        style: k18BoldTS,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              GetUtils.isEmail(value.toString())
                                  ? null
                                  : 'Email incorrectly formatted.',
                          decoration: const InputDecoration(
                              errorBorder: OutlineInputBorder(),
                              border: OutlineInputBorder(),
                              hintText: 'Email'),
                          onChanged: (val) {
                            _email.value = val;
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value!.length < 6
                            ? 'Password should be at least 6 characters.'
                            : null,
                        obscureText: true,
                        decoration: const InputDecoration(
                            errorBorder: OutlineInputBorder(),
                            border: OutlineInputBorder(),
                            hintText: 'Password'),
                        onChanged: (val) => _password.value = val,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      onboardSelection == 'newAccount'
                          ? TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (val) => val != _password.value
                                  ? 'passwords do not match'
                                  : null,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  errorBorder: OutlineInputBorder(),
                                  border: OutlineInputBorder(),
                                  hintText: 'Confirm Password'),
                              onChanged: (val) => _confirmed.value = val,
                            )
                          : Container(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Visibility(
                          visible: onboardSelection == 'newAccount',
                          child: const Text(
                            'By checking this box, I Agree to the Terms Of Service and Privacy Agreement',
                            style: kRegularTS,
                            textAlign: TextAlign.center,
                          )),
                      Visibility(
                          visible: onboardSelection == 'signin',
                          child: const Text(
                            'Welcome back! Lets Gooooo!',
                            style: k16BoldTS,
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 7.h,
                        width: 80.w,
                        child: ElevatedButton(
                          onPressed: () => {
                            GetUtils.isEmail(_email.value)
                                ? onboardSelection == 'newAccount'
                                    ? createAccount(_email.value.trim(),
                                        _password.value.trim())
                                    : login(_email.value.trim(),
                                        _password.value.trim())
                                : Get.snackbar('Error',
                                    'email not valid or password not greater than 6 characters.',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red)
                          },
                          child: Text(
                            onboardSelection == 'newAccount'
                                ? 'Create Account'
                                : 'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -12.h,
                child: SvgPicture.asset(
                  'assets/icons/logo_outlined.svg',
                  height: 18.h,
                ),
              ),
            ]),
        barrierColor: Colors.black.withOpacity(.9));
  }
}
