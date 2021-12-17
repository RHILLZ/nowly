import 'package:cool_alert/cool_alert.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';

class Dialogs {
  sessionCancellation(context, Function onTap) => CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      onConfirmBtnTap: () => onTap,
      backgroundColor: kPrimaryColor,
      title: 'Premature Cancellation',
      text:
          'Are you sure you want to end this session before the duration has completed?',
      barrierDismissible: false,
      // widget: Logo.mark(context, 8.h),
      lottieAsset: 'assets/alert.json',
      confirmBtnText: 'Yes',
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
}
