// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:nowly/Configs/configs.dart';
// import 'package:sizer/sizer.dart';

// class AuthBottomSheet extends StatelessWidget {
//   const AuthBottomSheet({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final onboardSelection = GetStorage().read('onboardSelection');
    // return Stack(
    //     clipBehavior: Clip.none,
    //     alignment: Alignment.center,
    //     fit: StackFit.expand,
    //     children: [
    //       SingleChildScrollView(
    //         child: Container(
    //           padding: EdgeInsets.symmetric(horizontal: 3.w),
    //           height: 70.h,
    //           width: 80.w,
    //           decoration: BoxDecoration(
    //               gradient: authPagesGradient(context),
    //               borderRadius: const BorderRadius.only(
    //                   topLeft: Radius.circular(20),
    //                   topRight: Radius.circular(20))),
    //           child: Column(
    //             children: <Widget>[
    //               SizedBox(
    //                 height: 5.h,
    //               ),
    //               Text(
    //                 onboardSelection == 'newAccount'
    //                     ? 'Create Account'.toUpperCase()
    //                     : 'Sign In'.toUpperCase(),
    //                 style: k18BoldTS,
    //                 textAlign: TextAlign.center,
    //               ),
    //               SizedBox(
    //                 height: 2.h,
    //               ),
    //               TextFormField(
    //                   autovalidateMode: AutovalidateMode.onUserInteraction,
    //                   validator: (value) => GetUtils.isEmail(value.toString())
    //                       ? null
    //                       : 'Email incorrectly formatted.',
    //                   decoration: const InputDecoration(
    //                       errorBorder: OutlineInputBorder(),
    //                       border: OutlineInputBorder(),
    //                       hintText: 'Email'),
    //                   onChanged: (val) {
    //                     _email.value = val;
    //                   }),
    //               SizedBox(
    //                 height: 2.h,
    //               ),
    //               TextFormField(
    //                 autovalidateMode: AutovalidateMode.onUserInteraction,
    //                 validator: (value) => value!.length < 6
    //                     ? 'Password should be at least 6 characters.'
    //                     : null,
    //                 obscureText: true,
    //                 decoration: const InputDecoration(
    //                     errorBorder: OutlineInputBorder(),
    //                     border: OutlineInputBorder(),
    //                     hintText: 'Password'),
    //                 onChanged: (val) => _password.value = val,
    //               ),
    //               SizedBox(
    //                 height: 2.h,
    //               ),
    //               onboardSelection == 'newAccount'
    //                   ? TextFormField(
    //                       autovalidateMode: AutovalidateMode.onUserInteraction,
    //                       validator: (val) => val != _password.value
    //                           ? 'passwords do not match'
    //                           : null,
    //                       obscureText: true,
    //                       decoration: const InputDecoration(
    //                           errorBorder: OutlineInputBorder(),
    //                           border: OutlineInputBorder(),
    //                           hintText: 'Confirm Password'),
    //                       onChanged: (val) => _confirmed.value = val,
    //                     )
    //                   : Container(),
    //               SizedBox(
    //                 height: 2.h,
    //               ),
    //               SizedBox(
    //                 height: 7.h,
    //                 width: 80.w,
    //                 child: ElevatedButton(
    //                   onPressed: () => {
    //                     GetUtils.isEmail(_email.value)
    //                         ? onboardSelection == 'newAccount'
    //                             ? createAccount(
    //                                 _email.value.trim(), _password.value.trim())
    //                             : login(
    //                                 _email.value.trim(), _password.value.trim())
    //                         : Get.snackbar('Error',
    //                             'email not valid or password not greater than 6 characters.',
    //                             snackPosition: SnackPosition.BOTTOM,
    //                             backgroundColor: Colors.red)
    //                   },
    //                   child: Text(
    //                     onboardSelection == 'newAccount'
    //                         ? 'Create Account'
    //                         : 'Sign in',
    //                     style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 16.sp,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         top: -12.h,
    //         child: SvgPicture.asset(
    //           'assets/icons/logo_outlined.svg',
    //           height: 18.h,
    //         ),
    //       ),
    //     ]);
//   }
// }
