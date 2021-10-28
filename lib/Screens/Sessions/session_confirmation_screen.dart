import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class SessionConfirmationScreen extends StatelessWidget {
  SessionConfirmationScreen({Key? key}) : super(key: key);

  static const routeName = '/SessionConfirmation';
  final SessionController _controller = Get.find<SessionController>();
  final StripeController _stripeController = Get.put(StripeController());
  final AgoraController _agoraVideoCallController = Get.put(AgoraController());
  final FilterController _filterController = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.user = Get.find<UserController>().user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('SESSION CONFIRMATION'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: UIParameters.screenPadding,
            child: MainButton(onTap: () async {
              final userName =
                  '${_controller.user.firstName} ${_controller.user.lastName}';
              final _session = SessionModel(
                  userID: _controller.user.id,
                  userName: userName,
                  userProfilePicURL: _controller.user.profilePicURL,
                  userStripeID: _controller.user.stripeCustomerId,
                  userPaymentMethodID: _controller.user.activePaymentMethodId,
                  trainerGenderPref: _filterController.genderPref.type,
                  sessionMode: _controller.sessionMode.mode,
                  sessionDuration: _controller.sessionDurationAndCost.duration,
                  sessionChargedAmount:
                      _controller.sessionDurationAndCost.amount,
                  sessionID: 'NWLY${DateTime.now().millisecondsSinceEpoch}',
                  sessionWorkoutType: _controller.sessionWorkOutType.type,
                  sessionWorkoutTypeImagePath:
                      _controller.sessionWorkOutType.imagePath);

              _agoraVideoCallController.session = _session;
              // ignore: unused_local_variable
              final durTimer =
                  _controller.sessionDurationAndCost.duration.substring(0, 2);
              final amount = _controller.sessionDurationAndCost.amount;
              final desc =
                  '${_controller.sessionDurationAndCost.duration} Minute ${_controller.sessionWorkOutType.type} Session';
              _agoraVideoCallController.user = _controller.user;
              _agoraVideoCallController.sessionDescription = desc;
              _agoraVideoCallController.sessionAmount = amount;
              // _agoraVideoCallController.sessionTimer = int.parse(durTimer) * 60;
              _agoraVideoCallController.startSession(
                  _session, _agoraVideoCallController);
            }),
          ),
        ),
        body: Obx(
          () => _stripeController.isProcessing
              ? _stripeController.loadScreen()
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
                                style: k20BoldTS.copyWith(color: Colors.white),
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
                                style: k20BoldTS.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient:
                                  trainingConfirmationCardGradient(context)),
                        ),
                        const Text(
                          'YOUR SESSION WILL BE FOR ',
                          style: k16BoldTS,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 5),
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
                          title: Text(
                            '${_controller.sessionDurationAndCost.duration} Minute ${_controller.sessionWorkOutType.type} Session',
                            style: k16BoldTS,
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Trainer Preference: ${_filterController.genderPref.type}'),
                              Text(
                                  'Location: ${_controller.sessionLocationName}'),
                            ],
                          ),
                          trailing: Text(
                            '\$' +
                                (_controller.sessionDurationAndCost.amount ~/
                                        100)
                                    .toString(),
                            style: k20BoldTS,
                          ),
                        ),
                        const Divider(
                          height: 20,
                          thickness: 3,
                        ),
                        Obx(() {
                          if (_controller.showTimes.value) {
                            return SessionLength();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 5),
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
                                Get.toNamed(AddPaymentMethodsScreen.routeName);

                                // if (_paymentController.myPaymentMethods.isNotEmpty) {
                                //   Get.toNamed(PaymentMethodsScreen.routeName);
                                // }
                              },
                              child: Row(
                                children: [
                                  _stripeController
                                          .activePaymentMethod.last4.isNotEmpty
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
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
                                                  .activePaymentMethod.last4)
                                            ])
                                      : const Text(
                                          'ADD PAYMENT METHOD',
                                          style: kRegularTS,
                                          overflow: TextOverflow.fade,
                                        ),
                                  const Icon(Icons.navigate_next),
                                ],
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
}
