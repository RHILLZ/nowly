import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';

class UserGoalScreen extends GetView<UserController> {
  UserGoalScreen({Key? key}) : super(key: key);
  static const routeName = '/myGoal';

  final UserController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    AppLogger.i(_controller.selectedGoals);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GOALS'),
      ),
      bottomSheet: SizedBox(
        height: 8.h,
        width: 100.w,
        child: Obx(() => RectButton(
              onPressed: () async {
                _controller.isChanged ? _controller.updateGoals() : null;
              },
              title: 'Update Goals'.toUpperCase(),
              fillColor: _controller.isChanged ? kActiveColor : null,
            )),
      ),
      body: SafeArea(
        child: Obx(
          () => _controller.isUploading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Padding(
                  padding: UIParameters.screenPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              ProfileImage(
                                imageURL: controller.user.profilePicURL,
                              ),
                              SizedBox(
                                  child: Text(
                                      '${_controller.user.firstName} ${_controller.user.lastName}',
                                      style: k20BoldTS)),
                            ],
                          ),
                        ),
                        const Text('MY GOALS'),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            runSpacing: 10,
                            spacing: 10,
                            children: List.generate(
                                _controller.allFitnessGoals.length,
                                (index) => Obx(
                                      () {
                                        return SmallTextCard(
                                            label: _controller
                                                .allFitnessGoals[index].goal,
                                            isSelected: _controller
                                                .selectedGoals
                                                .contains(_controller
                                                    .allFitnessGoals[index]
                                                    .goal),
                                            onTap: () {
                                              AppLogger.i(
                                                  _controller.selectedGoals);
                                              final item = _controller
                                                  .allFitnessGoals[index].goal;

                                              if (_controller.selectedGoals
                                                  .contains(item)) {
                                                _controller.selectedGoals
                                                    .remove(item);
                                                _controller.isChanged = true;
                                              } else {
                                                if (_controller
                                                        .selectedGoals.length >=
                                                    4) {
                                                  return;
                                                }
                                                _controller.selectedGoals
                                                    .add(item);
                                                _controller.isChanged = true;
                                              }
                                            });
                                      },
                                    )),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text('Primary GOAL'.toUpperCase()),
                        SizedBox(
                          height: 1.h,
                        ),
                        Center(
                          child: SmallTextCard(
                            isSelected: true,
                            // color: kPrimaryColor,
                            label: _controller.user.primaryGoal,
                            onTap: () {},
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 10),
                          child: Text('MY WEIGHT IS'),
                        ),
                        Obx(
                          () => DropDownBox(
                            title: 'Weight (lbs.)',
                            value: _controller.user.weight,
                            onTap: () {
                              Get.bottomSheet(BottomSheetContent(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => NumberPicker(
                                      value: int.parse(_controller.user.weight),
                                      minValue: 0,
                                      maxValue: 500,
                                      step: 1,
                                      haptics: true,
                                      onChanged: (value) {
                                        _controller.myWeight = value;
                                      },
                                    ),
                                  ),
                                ],
                              )));
                            },
                          ),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 15, bottom: 10),
                        //   child: Text('MY FAVORITE WORKOUTS ARE…'),
                        // ),
                        // Obx(() => _controller.myFavoriteWorkouts.isNotEmpty
                        //     ? GridView.count(
                        //         padding: EdgeInsets.zero,
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         shrinkWrap: true,
                        //         crossAxisCount:
                        //             (Get.width <= kWorkOutCardBreakWidth) ? 3 : 4,
                        //         childAspectRatio: 1.0,
                        //         mainAxisSpacing: 15.0,
                        //         crossAxisSpacing: 15.0,
                        //         children: [
                        //           ..._controller.myFavoriteWorkouts
                        //               .map(
                        //                 (type) => WorkOutCard(
                        //                   imagePath: type.imagePath,
                        //                   title: type.title,
                        //                   onSelecte: () {},
                        //                   isSelected: false,
                        //                 ),
                        //               )
                        //               .toList(),
                        //         ],
                        //       )
                        //     : const SizedBox()),
                      ],
                    ),
                  )
                  // : const SizedBox(),
                  ),
        ),
      ),
    );
  }
}
