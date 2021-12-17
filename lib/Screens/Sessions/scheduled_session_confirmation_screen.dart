// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:nowly/Configs/Constants/constants.dart';
// import 'package:nowly/Configs/configs.dart';
// import 'package:nowly/Controllers/controller_exporter.dart';
// import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
// import 'package:nowly/Widgets/widget_exporter.dart';
// import 'package:sizer/sizer.dart';

// class ScheduledSessionConfirmationScreen extends StatelessWidget {
//   ScheduledSessionConfirmationScreen({Key? key}) : super(key: key);

//   final StripeController _stripeController = Get.put(StripeController());
//   final SessionController _controller = Get.find<SessionController>();
//   final FilterController _filterController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     _controller.user = Get.find<UserController>().user;
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'FUTURE SESSION CONFIRMATION',
//             style: k16BoldTS,
//           ),
//           centerTitle: true,
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Padding(
//             padding: UIParameters.screenPadding,
//             child: MainButton(onTap: () async {
//               _controller.findTrainerForScheduledSession();
//             }),
//           ),
//         ),
//         body: Obx(
//           () => _stripeController.isProcessing
//               ? _stripeController.loadScreen()
//               : SafeArea(
//                   child: SingleChildScrollView(
//                     padding: UIParameters.screenPaddingHorizontal,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: kScreenPadding2),
//                           padding: UIParameters.screenPadding,
//                           height: Get.height * 0.25,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'YOU HAVE CHOSEN',
//                                 style: k20BoldTS.copyWith(color: Colors.white),
//                               ),
//                               Expanded(
//                                   child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       width: double.maxFinite,
//                                       child: SvgPicture.asset(
//                                         _controller
//                                             .sessionWorkOutType.imagePath,
//                                         fit: BoxFit.contain,
//                                       ))),
//                               Text(
//                                 _controller.sessionWorkOutType.type,
//                                 style: k20BoldTS.copyWith(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(40),
//                               gradient:
//                                   trainingConfirmationCardGradient(context)),
//                         ),
//                         const Divider(),
//                         _buildLocationSection(),
//                         const Divider(),
//                         _buildTimeAndDate(),
//                         // const Text(
//                         //   'YOUR SESSION WILL BE FOR ',
//                         //   style: k16BoldTS,
//                         // ),
//                         // Padding(
//                         //   padding: const EdgeInsets.only(top: 15.0, bottom: 5),
//                         //   child: SvgPicture.asset(
//                         //     'assets/icons/clock.svg',
//                         //     height: 5.h,
//                         //     color: UIParameters.isDarkMode(context)
//                         //         ? Colors.white
//                         //         : kActiveButtonColor,
//                         //   ),
//                         // ),
//                         // Text(
//                         //   _controller.sessionDurationAndCost.duration,
//                         //   style: k16BoldTS,
//                         // ),
//                         // const SizedBox(
//                         //   height: 10,
//                         // ),
//                         const Divider(
//                           height: 20,
//                           thickness: 3,
//                         ),
//                         ListTile(
//                           isThreeLine: true,
//                           title: Text(
//                             '${_controller.sessionDurationAndCost.duration} ${_controller.sessionWorkOutType.type} Session',
//                             style: k16BoldTS,
//                           ),
//                           subtitle: Text(
//                               'Trainer Preference: ${_filterController.genderPref.type}'),
//                           trailing: Text(
//                             '\$' +
//                                 (_controller.sessionDurationAndCost.amount ~/
//                                         100)
//                                     .toString(),
//                             style: k20BoldTS,
//                           ),
//                         ),
//                         const Divider(
//                           height: 20,
//                           thickness: 3,
//                         ),
//                         Obx(() {
//                           if (_controller.showTimes.value) {
//                             return SessionLength();
//                           }
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 10, bottom: 5),
//                             child: TextButton(
//                                 onPressed: () {
//                                   _controller.showTimes.toggle();
//                                 },
//                                 style: TextButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(20)),
//                                     backgroundColor:
//                                         Theme.of(context).cardColor),
//                                 child: const Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 15, vertical: 5),
//                                   child: Text(
//                                     'Change Time',
//                                     style: k16BoldTS,
//                                   ),
//                                 )),
//                           ); // loading shimmer
//                         }),
//                         Row(
//                           children: [
//                             const Text(
//                               'Payment Method:',
//                               style: kRegularTS,
//                             ),
//                             const Spacer(),
//                             TextButton(
//                               onPressed: () {
//                                 Get.toNamed(AddPaymentMethodsScreen.routeName);

//                                 // if (_paymentController.myPaymentMethods.isNotEmpty) {
//                                 //   Get.toNamed(PaymentMethodsScreen.routeName);
//                                 // }
//                               },
//                               child: Row(
//                                 children: [
//                                   _stripeController
//                                           .activePaymentMethod.last4.isNotEmpty
//                                       ? Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                               FittedBox(
//                                                   fit: BoxFit.contain,
//                                                   child: _stripeController
//                                                               .activePaymentMethod
//                                                               .brand ==
//                                                           'visa'
//                                                       ? VISAIMAGE
//                                                       : MASTERCARDIMAGE),
//                                               SizedBox(
//                                                 width: 2.w,
//                                               ),
//                                               Text(_stripeController
//                                                   .activePaymentMethod.last4)
//                                             ])
//                                       : const Text(
//                                           'ADD PAYMENT METHOD',
//                                           style: kRegularTS,
//                                           overflow: TextOverflow.fade,
//                                         ),
//                                   const Icon(Icons.navigate_next),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'Sessions will begin immediately upon confirmation. Make sure you’re all prettied up before starting.',
//                           style: kRegularTS,
//                           textAlign: TextAlign.center,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//         ));
//   }

//   Widget _buildLocationSection() => ListTile(
//         title: Text('Session Location: ${_controller.sessionLocationName}'),
//         // trailing: Container(
//         //   constraints: BoxConstraints(maxWidth: 30.w),
//         //   child: GoogleMap(
//         //       rotateGesturesEnabled: false,
//         //       scrollGesturesEnabled: false,
//         //       zoomGesturesEnabled: false,
//         //       zoomControlsEnabled: false,
//         //       myLocationButtonEnabled: false,
//         //       initialCameraPosition: CameraPosition(
//         //         target: _controller.sessionLocationCoords,
//         //         zoom: 18,
//         //       )),
//         // ),
//       );

//   Widget _buildTimeAndDate() => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text('Time Scheduled'),
//               SizedBox(
//                 height: 1.h,
//               ),
//               Text(_controller.sessionTimeScheduled)
//             ],
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text('Date Scheduled'),
//               SizedBox(
//                 height: 1.h,
//               ),
//               Text(_controller.sessionDateScheduled)
//             ],
//           ),
//         ],
//       );
// }
