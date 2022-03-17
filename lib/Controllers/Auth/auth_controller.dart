import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/shared_preferences/preferences_controller.dart';
import 'package:nowly/Screens/Nav/legals_view.dart';
import 'package:nowly/Screens/OnBoarding/user_registration_view.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/env.dart';
import 'package:nowly/Utils/app_logger.dart';
import 'package:nowly/root.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PreferencesController _preferences = Get.put(PreferencesController());
  final _prefs = Rxn<SharedPreferences>();

  late Mixpanel mixpanel;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final RxString _email = RxString('');
  final RxString _password = RxString('');
  final RxString _confirmed = RxString('');
  late RxBool _agreedToTerms;

  get firebaseUser => _firebaseUser.value;
  get auth => _auth;
  get agreedToTerms => _agreedToTerms.value;
  Mixpanel get mix => mixpanel;

  set agreedToTerms(value) => _agreedToTerms.value = value;

  @override
  void onInit() {
    _prefs.value = _preferences.prefs;
    _agreedToTerms = RxBool(_prefs.value?.getBool('agreeToTerms') ?? false);
    _firebaseUser.bindStream(_auth.authStateChanges());
    initMixpanel();
    super.onInit();
  }

  void createAccount(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      unawaited(Get.to(UserRegistrationView()));

      //CHECK ACCOUNT TYPE THEN NAVIGATE TO APPROPIATE SCREEN
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Problem creating user', e.message!,
          snackPosition: SnackPosition.BOTTOM);
    } catch (exception) {
      print(exception.toString());
    }
  }

  /// logs the user in by email and password
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final id = (_firebaseUser.value?.uid) ?? '';

      final _user = await FirebaseFutures().getUserInFirestoreInstance(id);

      if (!_user.exists) {
        await _preferences.prefs?.setBool('register', false);
        unawaited(
          Get.off(() {
            return UserRegistrationView();
          }),
        );
      } else {
        await _preferences.prefs?.setBool('register', true);
        unawaited(
          Get.to(() {
            return const Root();
          }),
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Problem signing in user',
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (exception) {
      print(exception.toString());
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
      Get.to(() => const Root());
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
    // re-initialise _prefs, prevent it having null value
    _prefs.value = _preferences.prefs;
    final onboardSelection = _prefs.value?.getString('onboardSelection');
    Get.bottomSheet(
        Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  height: 75.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      gradient: onBoardingGradient(context),
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
                          child: Obx(() => CheckboxListTile(
                              checkColor: kActiveColor,
                              activeColor: kPrimaryColor,
                              title: RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                      style: kRegularTS.copyWith(
                                          fontSize: 10.sp, height: 1.4),
                                      children: [
                                        const TextSpan(
                                            text:
                                                'By checking this box, I hearby agree to nowly '),
                                        TextSpan(
                                            text: 'Terms of Services ',
                                            style: k10BoldTS.copyWith(
                                                fontSize: 10.sp,
                                                color: UIParameters.isDarkMode(
                                                        context)
                                                    ? kPrimaryColor
                                                    : kActiveButtonColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () =>
                                                  loadDoc('nowlyTOS.pdf')),
                                        const TextSpan(text: 'and '),
                                        TextSpan(
                                            text: 'Privacy Agreement',
                                            style: k10BoldTS.copyWith(
                                                fontSize: 10.sp,
                                                color: UIParameters.isDarkMode(
                                                        context)
                                                    ? kPrimaryColor
                                                    : kActiveButtonColor),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap =
                                                  () => loadDoc('nowlyPA.pdf'))
                                      ])),
                              value: _agreedToTerms.value,
                              selected: _agreedToTerms.value,
                              onChanged: (v) async {
                                // Cache user reading the terms of agreement
                                await _prefs.value
                                    ?.setBool('agreeToTerms', v ?? false);
                                _agreedToTerms.toggle();
                              }))),
                      SizedBox(
                        height: 2.h,
                      ),
                      Visibility(
                          visible: onboardSelection == 'signin',
                          child: const Text(
                            'Welcome Back, Let GOOOO! 💥',
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
                                    ? _agreedToTerms.value
                                        ? createAccount(_email.value.trim(),
                                            _password.value.trim())
                                        : termsWarningSnackbar()
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
                top: -10.h,
                child: SvgPicture.asset(
                  'assets/logo/mark.svg',
                  height: 14.h,
                ),
              ),
            ]),
        barrierColor: Colors.black.withOpacity(1));
  }

  termsWarningSnackbar() => Get.snackbar('Please Review Terms and Conditions.',
      'Check box to agree to Terms and Conditions.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 4));

  Future<File?> _storeDoc(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    return file;
  }

  Future loadDoc(filename) async {
    Get.isBottomSheetOpen == true ? Get.back() : null;
    final bytes = await FirebaseStorage().getLegalDoc(filename);
    final file = await _storeDoc(filename, bytes);
    AppLogger.info(file);
    file != null
        ? _openPDF(file)
        : Get.snackbar('Something went wrong!',
            'Unable to download document at this time. Please try again later.');
  }

  void _openPDF(File file) => Get.to(() => LegalView(file: file));

  Future<void> initMixpanel() async {
    mixpanel = await Mixpanel.init(Env.mixPanelToken ?? '',
        optOutTrackingDefault: false);
  }
}
