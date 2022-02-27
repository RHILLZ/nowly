import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/Constants/constants.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';

class SessionConfirmationScreen2 extends StatelessWidget {
  SessionConfirmationScreen2(
      {Key? key,
      required TrainerInPersonSessionController
          trainerInPersonSessionController})
      : _trainerInPersonSessionController = trainerInPersonSessionController,
        super(key: key);

  static const routeName = '/session_confirmation_2';
  final SessionController _controller = Get.put(SessionController());
  final UserController _userController = Get.find();
  final StripeController _stripeController = Get.put(StripeController());
  final MapNavigatorController _mapNavigatorController =
      Get.put(MapNavigatorController());
  final TrainerInPersonSessionController _trainerInPersonSessionController;

  @override
  Widget build(BuildContext context) {
    final _sessionDetails = _trainerInPersonSessionController.trainerSession;
    _controller.sessionDurAndCosts.value =
        _trainerInPersonSessionController.trainerSession.sessionLengths;
    _controller.sessionDurationAndCost =
        _trainerInPersonSessionController.selectedLength.value;
    final _city = Get.find<MapController>().city;
    final _sessionFee = (_controller.sessionDurationAndCost.cost / 100);
    final st = SessionDurationAndCostModel.salesTaxByLoc[_city] ?? 0.0;
    final _salesTax = _sessionFee * st;
    final _totalCost = _sessionFee + _salesTax;
    final _totalCharge = (_totalCost * 100).toString().split('.')[0];

    _controller.context = context;

    return Scaffold(
        appBar: AppBar(
          title: const FittedBox(
              fit: BoxFit.fitWidth, child: Text('SESSION CONFIRMATION')),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomAppBar(
          child: GetBuilder<MapNavigatorController>(
              id: 'navigationIndicatorId',
              builder:
                  (_) =>
                      _mapNavigatorController.hasThisOnGoingNavigation(
                                  _trainerInPersonSessionController) ==
                              NavigationStatus.notAvailable
                          ? Padding(
                              padding: UIParameters.screenPadding,
                              child: Obx(() => MainButton(
                                  title: _controller.isProcessing
                                      ? 'CANCEL'
                                      : 'I’M SO PUMPED, LETS GO',
                                  onTap: _controller.isProcessing
                                      ? () => _controller.cancel(context)
                                      : () {
                                          // ;
                                          final userName =
                                              '${_userController.user.firstName} ${_userController.user.lastName}';
                                          final trainerName =
                                              '${_sessionDetails.trainer.firstName} ${_sessionDetails.trainer.lastName}';
                                          final _session = SessionModel(
                                              sessionID:
                                                  'NWLY${DateTime.now().millisecondsSinceEpoch}',
                                              sessionMode: 'IN PERSON',
                                              sessionWorkoutType:
                                                  _trainerInPersonSessionController
                                                      .selectedWorkoutType
                                                      .value
                                                      .type,
                                              sessionWorkoutTypeImagePath:
                                                  _trainerInPersonSessionController
                                                      .selectedWorkoutType
                                                      .value
                                                      .imagePath,
                                              sessionDuration: _controller
                                                  .sessionDurationAndCost
                                                  .duration,
                                              sessionChargedAmount:
                                                  int.parse(_totalCharge),
                                              salesTaxApplied: _salesTax > 0.0,
                                              sessionSalesTax: _salesTax,
                                              userID: _userController.user.id,
                                              userName: userName,
                                              userPaymentMethodID:
                                                  _userController.user
                                                      .activePaymentMethodId,
                                              userProfilePicURL: _userController
                                                  .user.profilePicURL,
                                              userStripeID: _userController
                                                  .user.stripeCustomerId,
                                              trainerID: _sessionDetails.trainer.id,
                                              trainerName: trainerName,
                                              trainerProfilePicURL: _sessionDetails.trainer.profilePicURL,
                                              trainerStripeID: _sessionDetails.trainer.stripeAccountId,
                                              eta: _trainerInPersonSessionController.durationText.value);
                                          final durTimer = _controller
                                              .sessionDurationAndCost.duration
                                              .substring(0, 2);
                                          _controller.sessionTime =
                                              int.parse(durTimer) * 60;

                                          final tokenId =
                                              _sessionDetails.trainer.tokenId;
                                          if (_stripeController
                                                  .activePaymentMethod.last4 ==
                                              '') {
                                            Dialogs().addPayMethod(context);
                                            return;
                                          }
                                          _controller.engageTrainer(
                                              _session,
                                              tokenId!,
                                              context,
                                              _trainerInPersonSessionController);
                                        })))
                          : Padding(
                              padding: UIParameters.screenPadding,
                              child: UserNavigatorIndicatorDetailedBanner(
                                  sessionController:
                                      _trainerInPersonSessionController),
                            )),
        ),
        body: Obx(
          () => _controller.isProcessing
              ? _loadScreen()
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: UIParameters.screenPaddingHorizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(
                              vertical: kScreenPadding2),
                          padding: UIParameters.screenPadding,
                          height: 25.h,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'YOU HAVE CHOSEN',
                                  style:
                                      k20BoldTS.copyWith(color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: ProfileImage(
                                      imageURL:
                                          _sessionDetails.trainer.profilePicURL,
                                      rad: 5),
                                ),
                                Text(
                                  '${_sessionDetails.trainer.firstName} ${_sessionDetails.trainer.lastName}',
                                  style:
                                      k20BoldTS.copyWith(color: Colors.white),
                                ),
                                // Text(_sessionDetails.trainer.address ?? '',
                                //     style: kRegularTS.copyWith(color: Colors.white))
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.5),
                                      BlendMode.multiply),
                                  image: const AssetImage(
                                      'assets/images/map/map.png')),
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        const Text('YOUR SESSION WILL BE FOR ',
                            style: k16BoldTS),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                          child: SvgPicture.asset('assets/images/clock.svg',
                              height: 5.h,
                              color: UIParameters.isDarkMode(context)
                                  ? Colors.white
                                  : null),
                        ),
                        Text(_controller.sessionDurationAndCost.duration,
                            style: k16BoldTS),

                        const SizedBox(height: 10),
                        const Divider(height: 20, thickness: 3),
                        ListTile(
                          title: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                                '${_trainerInPersonSessionController.selectedWorkoutType.value.type} SESSION'
                                    .toUpperCase(),
                                style: k16BoldTS),
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

                        const Divider(height: 20, thickness: 3),

                        // if (_trainerInPersonSessionController.showTimes.value) {
                        //   return SessionLength(
                        //       // onTap: (value) {
                        //       //   _trainerSessionC.selectedLength.value = value;
                        //       // },
                        //       );
                        // }
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10, bottom: 5),
                        //   child: TextButton(
                        //       onPressed: () {
                        //         _trainerInPersonSessionController.showTimes
                        //             .toggle();
                        //       },
                        //       style: TextButton.styleFrom(
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(20)),
                        //           backgroundColor: Theme.of(context).cardColor),
                        //       child: const Padding(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: 15, vertical: 5),
                        //         child: Text('Change Time', style: k16BoldTS),
                        //       )),
                        // ), // loading shimmer

                        Row(
                          children: [
                            const Expanded(child: Text('PAYMENT METHOD')),
                            TextButton(
                              onPressed: () {
                                Get.to(AddPaymentMethodsScreen());
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
                                              _stripeController
                                                          .activePaymentMethod
                                                          .brand ==
                                                      'visa'
                                                  ? VISAIMAGE
                                                  : MASTERCARDIMAGE,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StaticsWidget(
                                  imagePath: 'assets/icons/map.svg',
                                  lable1: 'DISTANCE',
                                  lable2: _trainerInPersonSessionController
                                              .sessionDistandeDuratiom.value ==
                                          null
                                      ? 'N/A'
                                      : _trainerInPersonSessionController
                                          .sessionDistandeDuratiom
                                          .value!
                                          .distance
                                          .text),
                              StaticsWidget(
                                  imagePath: 'assets/icons/clock1.svg',
                                  lable1: 'DURATION',
                                  lable2: _trainerInPersonSessionController
                                      .selectedLength.value.duration),
                              StaticsWidget(
                                imagePath: 'assets/icons/clock2.svg',
                                lable1: 'ETA',
                                lable2: _trainerInPersonSessionController
                                            .sessionDistandeDuratiom.value ==
                                        null
                                    ? 'N/A'
                                    : _trainerInPersonSessionController
                                        .sessionDistandeDuratiom
                                        .value!
                                        .duration
                                        .text,
                              )
                            ],
                          ),
                        ),
                        const Text(
                          'Sessions will begin immediately upon QR scan confirmation.',
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
              'Please wait, connecting with trainer..',
              style: k16BoldTS,
            )
          ],
        ),
      );
}
