import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
import 'package:nowly/Services/Stripe/android_stripe_service.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class SessionConfirmationScreen extends StatelessWidget {
  SessionConfirmationScreen({Key? key}) : super(key: key);

  final _androidStripeController = Get.put(AndroidStripeController());
  static const routeName = '/SessionConfirmation';
  final SessionController _controller = Get.find<SessionController>();
  final StripeController _stripeController = Get.put(StripeController());
  final AgoraController _agoraVideoCallController = Get.put(AgoraController());
  final FilterController _filterController = Get.find();
  // ignore: unused_field
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.user = Get.find<UserController>().user;
    final _city = Get.find<MapController>().city;
    final _sessionFee = (_controller.sessionDurationAndCost.cost / 100);
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = _sessionFee * st;
    final _totalCost = _sessionFee + _salesTax;
    final _totalCharge = (_totalCost * 100).toString().split('.')[0];

    AppLogger.i(_salesTax);
    _agoraVideoCallController.context = context;
    _controller.context = context;
    AppLogger.i('STRIPE: ${_stripeController.activePaymentMethod.last4}');

    return Scaffold(
        appBar: AppBar(
          title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'SESSION CONFIRMATION',
                style: k16BoldTS.copyWith(fontSize: 14),
              )),
          centerTitle: true,
        ),
        bottomNavigationBar: Obx(() => BottomAppBar(
              child: Padding(
                padding: UIParameters.screenPadding,
                child: _agoraVideoCallController.isSearching
                    ? MainButton(
                        title: 'CANCEL',
                        onTap: () => _agoraVideoCallController.cancel(context))
                    : MainButton(onTap: () async {
                        final userName =
                            '${_controller.user.firstName} ${_controller.user.lastName}';

                        final _session = SessionModel(
                            userID: _controller.user.id,
                            userName: userName,
                            userProfilePicURL: _controller.user.profilePicURL,
                            userStripeID: _controller.user.stripeCustomerId,
                            userPaymentMethodID:
                                _controller.user.activePaymentMethodId,
                            trainerGenderPref:
                                _filterController.genderPref.type,
                            sessionMode: 'Virtual',
                            salesTaxApplied: _salesTax > 0.0,
                            sessionSalesTax: _salesTax,
                            sessionDuration:
                                _controller.sessionDurationAndCost.duration,
                            sessionChargedAmount: int.parse(_totalCharge),
                            sessionID:
                                'NWLY${DateTime.now().millisecondsSinceEpoch}',
                            sessionWorkoutType:
                                _controller.sessionWorkOutType.type,
                            sessionWorkoutTypeImagePath:
                                _controller.sessionWorkOutType.imagePath);

                        // ignore: unused_local_variable
                        final durTimer = _controller
                            .sessionDurationAndCost.duration
                            .substring(0, 2);
                        final amount = int.parse(_totalCharge);
                        final desc =
                            '${_controller.sessionDurationAndCost.duration} Minute ${_controller.sessionWorkOutType.type} Session';
                        _agoraVideoCallController.currentVirtualSession =
                            _session;
                        _controller.currentSession = _session;
                        _agoraVideoCallController.user = _controller.user;
                        _agoraVideoCallController.sessionDescription = desc;
                        _agoraVideoCallController.sessionAmount = amount;
                        _agoraVideoCallController.sessionTimer =
                            int.parse(durTimer) * 60;

                        // if (_stripeController.activePaymentMethod.last4 == '') {
                        //   Dialogs().addPayMethod(context);
                        //   return;
                        // }
                        await _androidStripeController.initPaymentSheet();

                        _agoraVideoCallController.startSession(
                            context, _session);

                        //TRACK SESSION CALL WITH MIXPANEL
                        Get.find<AuthController>()
                            .mix
                            .track('Virtual Session Call');
                      }),
              ),
            )),
        body: Obx(
          () => _stripeController.isProcessing
              ? _stripeController.loadScreen()
              : _agoraVideoCallController.isSearching
                  ? _loadScreen()
                  : SafeArea(
                      child: SingleChildScrollView(
                        padding: UIParameters.screenPaddingHorizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: kScreenPadding2),
                              padding: UIParameters.screenPadding,
                              height: Get.height * 0.25,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'YOU HAVE CHOSEN',
                                    style:
                                        k20BoldTS.copyWith(color: Colors.white),
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          width: double.maxFinite,
                                          child: SvgPicture.asset(
                                            _controller
                                                .sessionWorkOutType.imagePath,
                                            fit: BoxFit.contain,
                                          ))),
                                  Text(
                                    _controller.sessionWorkOutType.type,
                                    style:
                                        k20BoldTS.copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  gradient: trainingConfirmationCardGradient(
                                      context)),
                            ),
                            const Text(
                              'YOUR SESSION WILL BE FOR ',
                              style: k16BoldTS,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, bottom: 5),
                              child: SvgPicture.asset(
                                'assets/icons/clock.svg',
                                height: 5.h,
                                color: UIParameters.isDarkMode(context)
                                    ? Colors.white
                                    : kActiveButtonColor,
                              ),
                            ),
                            Text(
                              _controller.sessionDurationAndCost.duration,
                              style: k16BoldTS,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              thickness: 3,
                            ),
                            ListTile(
                              isThreeLine: true,
                              leading: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '${_controller.sessionWorkOutType.type} Session',
                                  style: k20BoldTS,
                                ),
                              ),
                              subtitle: Visibility(
                                visible:
                                    _filterController.genderPref.type != 'NONE',
                                child: Text(
                                    'Trainer Preference: ${_filterController.genderPref.type}'),
                              ),
                            ),
                            _controller.buildSessionFee(),
                            Visibility(
                                visible: _controller.applySalesTax(),
                                child: _controller.buildSalesTax()),
                            SizedBox(
                              height: 1.h,
                            ),
                            _controller.buildTotalCost(),
                            const Divider(
                              height: 1,
                              thickness: 3,
                            ),
                            Obx(() {
                              if (_controller.showTimes.value) {
                                return SessionLength();
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: TextButton(
                                    onPressed: () {
                                      _controller.showTimes.toggle();
                                    },
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor:
                                            Theme.of(context).cardColor),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        'Change Time',
                                        style: k16BoldTS,
                                      ),
                                    )),
                              ); // loading shimmer
                            }),
                            Row(
                              children: [
                                const Text(
                                  'Payment Method:',
                                  style: kRegularTS,
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    Get.to(() => AddPaymentMethodsScreen());

                                    // if (_paymentController.myPaymentMethods.isNotEmpty) {
                                    //   Get.toNamed(PaymentMethodsScreen.routeName);
                                    // }
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Row(
                                      children: [
                                        _stripeController.activePaymentMethod
                                                .last4.isNotEmpty
                                            ? FittedBox(
                                                fit: BoxFit.contain,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: _stripeController
                                                                      .activePaymentMethod
                                                                      .brand ==
                                                                  'visa'
                                                              ? VISAIMAGE
                                                              : MASTERCARDIMAGE),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Text(_stripeController
                                                          .activePaymentMethod
                                                          .last4)
                                                    ]),
                                              )
                                            : const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'ADD PAY METHOD',
                                                  style: kRegularTS,
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ),
                                        const Icon(Icons.navigate_next),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Sessions will begin immediately upon confirmation. Make sure you’re all prettied up before starting.',
                              style: kRegularTS,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
        ));
  }

  _loadScreen() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            HeartbeatProgressIndicator(
                child: SvgPicture.asset(
              'assets/logo/mark.svg',
              height: 6.h,
            )),
            SizedBox(
              height: 4.h,
            ),
            const Text(
              'Please wait, searching for available trainer..',
              style: k16BoldTS,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
}
