// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nowly/Controllers/controller_exporter.dart';
// import 'package:nowly/Screens/Stripe/add_card.dart';
// import 'package:nowly/Utils/app_logger.dart';
// import 'package:nowly/Widgets/widget_exporter.dart';
// import 'package:sizer/sizer.dart';

// class AddPaymentMethodsScreen extends StatelessWidget {
//   AddPaymentMethodsScreen({Key? key}) : super(key: key);

//   static const routeName = '/addPaymentMethods';
//   // final PaymentController _controller = Get.find();
//   final StripeController _stripeController = Get.put(StripeController());

//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     final activePM = _stripeController.activePaymentMethod;
//     AppLogger.info('${activePM.last4}');
//     if (activePM.last4 != '' ||
//         Get.find<UserController>().user.activePaymentMethodId != null) {
//       _stripeController.getAccountDetails();
//       Future.delayed(const Duration(seconds: 1),
//           () => _stripeController.getPaymentMethods());
//     }
//     AppLogger.info(activePM);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PAYMENT'),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text('Active Pay Method '),
//               SizedBox(
//                 height: 2.h,
//               ),
//               _stripeController.isGettingAccount
//                   ? _stripeController.loadScreen()
//                   : CreditCardWidget(cc: _stripeController.activePaymentMethod),
//               SizedBox(height: 2.h),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text('Payment Methods'),
//               ),
//               _stripeController.paymentMethods.isEmpty
//                   ? ListTile(
//                       onLongPress: () =>
//                           _stripeController.addNewPaymentWarning(),
//                       onTap: () {},
//                       leading: FittedBox(
//                           fit: BoxFit.contain,
//                           child: Icon(
//                             Icons.payment,
//                             size: 30.sp,
//                           )),
//                       title: Text('No Payment Methods on File'.toUpperCase()),
//                       trailing:
//                           const Icon(Icons.close_rounded, color: Colors.red))
//                   : Expanded(child: UserPaymentMethodsList()),
//               _stripeController.paymentMethods.isEmpty
//                   ? Expanded(
//                       child: SizedBox(
//                         height: 2.h,
//                       ),
//                     )
//                   : Container(),
//               Align(
//                 alignment: Alignment.center,
//                 child: CustomStripeButton(
//                     label: 'Add New Card', action: () => goToAddCard),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   goToAddCard() => Get.to(() => UserAddCardScreen());
// }
