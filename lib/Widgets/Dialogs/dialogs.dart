import 'package:cool_alert/cool_alert.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Logo/logos.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:sizer/sizer.dart';

class Dialogs {
  sessionCancelled(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      backgroundColor: kPrimaryColor,
      title: 'Session Cancelled',
      text: 'Your session has been cancelled successfully.',
      barrierDismissible: true,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'OK',
      confirmBtnColor: kPrimaryColor,
      width: 90.w);
  sessionCancelledByOther(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      backgroundColor: kPrimaryColor,
      title: 'Session Cancelled',
      text: 'This session was cancelled.',
      barrierDismissible: true,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'OK',
      confirmBtnColor: kPrimaryColor,
      width: 90.w);
  sessionCancellation(context, Function onTap) => CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      onConfirmBtnTap: () => onTap(),
      backgroundColor: kPrimaryColor,
      title: 'Early Cancellation',
      text: 'End this session before the duration has completed?',
      barrierDismissible: false,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'Yes',
      onCancelBtnTap: () => Get.back(),
      cancelBtnText: 'Nevermind',
      confirmBtnColor: kPrimaryColor,
      width: 80.w);

  locationCheck(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      backgroundColor: kPrimaryColor,
      title: 'Location Check',
      text:
          'Please confirm you are in the area that you will conduct in person sessions.',
      barrierDismissible: false,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'Yes I Am',
      cancelBtnText: 'Not Yet',
      confirmBtnColor: kPrimaryColor,
      width: 80.w);

  trainerUnavailable(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      backgroundColor: kPrimaryColor,
      title: 'Trainer Unavailable',
      text: 'Sorry, Trainer is not able to take session at this time.',
      barrierDismissible: false,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/unavailable.json',
      confirmBtnText: 'Ok',
      confirmBtnColor: kPrimaryColor,
      loopAnimation: false,
      width: 80.w);

  contactInfo(context, launchEmail) => CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      backgroundColor: kPrimaryColor,
      title: 'Contact Us',
      text: 'support@nowly.io',
      barrierDismissible: true,
      // widget: Logo.mark(5.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'contact',
      onConfirmBtnTap: () => launchEmail(),
      confirmBtnColor: kPrimaryColor,
      loopAnimation: false,
      width: 90.w);

  mapInfo(context, showAgain, dontShowAgain) => CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      backgroundColor: kPrimaryColor,
      title: 'In Person Sessions',
      text:
          'Trainers who are available for in person sessions will appear on the map, with this symbol',
      barrierDismissible: false,
      widget: Logo.mark(5.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'Got it',
      cancelBtnText: 'Show again',
      onConfirmBtnTap: () => dontShowAgain(),
      onCancelBtnTap: () => showAgain(),
      confirmBtnColor: kPrimaryColor,
      loopAnimation: false,
      width: 95.w);

  noTrainersUnavailable(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      backgroundColor: kPrimaryColor,
      title: 'Trainer Unavailable',
      text:
          'Sorry, Could not locate a trainer online for session at this time.',
      barrierDismissible: false,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/unavailable.json',
      confirmBtnText: 'Ok',
      confirmBtnColor: kPrimaryColor,
      loopAnimation: false,
      width: 80.w);

  // deletePayMethod(context, pmID) => CoolAlert.show(
  //     context: context,
  //     type: CoolAlertType.confirm,
  //     backgroundColor: kPrimaryColor,
  //     title: 'Delete Card',
  //     text: 'Are you sure you want to delete payment card?',
  //     barrierDismissible: false,
  //     // widget: Logo.mark(context, 8.h),
  //     lottieAsset: 'assets/alert.json',
  //     confirmBtnText: 'Delete',
  //     onConfirmBtnTap: () =>
  //         Get.find<StripeController>().removePaymentMethod(pmID),
  //     onCancelBtnTap: () => Get.back(),
  //     cancelBtnText: 'Nevermind',
  //     confirmBtnColor: kPrimaryColor,
  //     loopAnimation: false,
  //     width: 90.w);

  addPayMethod(context) => CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      backgroundColor: kPrimaryColor,
      title: 'No Payment Method',
      text: 'Please add payment method before you can continue.',
      barrierDismissible: false,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'Ok',
      confirmBtnColor: kPrimaryColor,
      loopAnimation: false,
      width: 90.w);
}
