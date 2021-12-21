import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Sessions/session_confirmation_screen.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class UserHomeView extends StatelessWidget {
  UserHomeView({Key? key}) : super(key: key);

  final SessionController _sessionController = Get.put(SessionController());
  // ignore: unused_field
  final UserController _userController = Get.put(UserController());
  final FilterController _filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    AppLogger.i('Home Screen');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 30.h,
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: Obx(() {
                      if (!_sessionController.isWorkoutsLoaded.value) {
                        return const SizedBox(); // loading shimmer
                      }

                      return HomeScreenHeader(
                          workOutType: _sessionController.sessionWorkOutType);
                    }),
                  )),
              FixedWidthContainer(
                child: Padding(
                  padding: UIParameters.screenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SESSION TRAINING TYPES',
                        style: k16BoldTS,
                      ),
                      const SizedBox(height: 15),
                      Obx(() {
                        if (!_sessionController.isWorkoutsLoaded.value) {
                          return const SizedBox(); // loading shimmer
                        }

                        return GridView.count(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          children: [
                            ..._sessionController.showingWorkoutTypes
                                .map((type) => Obx(
                                      () => WorkOutCard(
                                        imagePath: type.imagePath,
                                        isSelected: _sessionController
                                                .sessionWorkOutType ==
                                            type,
                                        title: type.type,
                                        onSelecte: () {
                                          _sessionController
                                              .sessionWorkOutType = type;
                                        },
                                      ),
                                    ))
                                .toList(),
                            Obx(
                              () {
                                if (_sessionController.homeExpanded.isTrue) {
                                  return WorkOutCard(
                                    child: const SeeLessButton(),
                                    imagePath: '',
                                    isSelected: false,
                                    title: '',
                                    onSelecte: () {
                                      _sessionController
                                          .toogleShowingWorkouts();
                                    },
                                  );
                                } else {
                                  return WorkOutCard(
                                    child: const SeeMoreButton(),
                                    imagePath: '',
                                    isSelected: false,
                                    title: '',
                                    onSelecte: () {
                                      _sessionController
                                          .toogleShowingWorkouts();
                                    },
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      }),
                      Obx(() {
                        if (!_sessionController.isWorkoutsLoaded.value) {
                          return const SizedBox(); // loading shimmer
                        }
                        return SessionLength();
                      }),
                      // Obx(() {
                      //   if (!_sessionController.isSessionTypeLoaded.value) {
                      //     return const SizedBox(); // loading shimmer
                      //   }
                      //   return SessionMode();
                      // }),
                      Obx(() => _sessionController.sessionMode.mode ==
                              'In Person'.toUpperCase()
                          ? HomeRadius(controller: _filterController)
                          : Container()),
                      const TrainerPreference(),
                      // const Avalability(),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Now we’re talking! 30 minutes \n a day is the winning formula',
                            style: k16RegularTS,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      MainButton(
                        onTap: () async {
                          final _ = _sessionController;
                          // ignore: unused_local_variable

                          Get.to(() => SessionConfirmationScreen());
                          // Get.to(() => SessionCompleteScreen(
                          //     session: SessionModel.dummySessionModel,
                          //     sessionController: _sessionController));
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
