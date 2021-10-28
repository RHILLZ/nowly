import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:numberpicker/numberpicker.dart';

class MyGoalScreen extends GetView<UserController> {
  MyGoalScreen({Key? key}) : super(key: key);
  static const routeName = '/myGoal';

  final UserController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GOALS'),
      ),
      body: SafeArea(
        child: Obx(
          () => Padding(
              padding: UIParameters.screenPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: kPrimaryColor,
                            backgroundImage:
                                NetworkImage(_controller.user.profilePicURL),
                          ),
                          SizedBox(
                              child: Text(_controller.user.firstName,
                                  style: k20BoldTS)),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(top: 5, bottom: 10),
                          //   child: SizedBox(
                          //     width: 200,
                          //     child: Text(
                          //       controller
                          //           .userController.userModel!.address!,
                          //       textAlign: TextAlign.center,
                          //       style: k16RegularTS,
                          //       maxLines: 4,
                          //     ),
                          //   ),
                          // ),
                          // SvgPicture.asset(controller.userController
                          //     .userModel!.myPrimaryFitnessGoals.imagePath),
                        ],
                      ),
                    ),
                    const Text('MY GOAL...'),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.center,
                      runSpacing: 10,
                      spacing: 10,
                      children: List.generate(
                          _controller.allFitnessGoals.length,
                          (index) => Obx(
                                () {
                                  UserModel user = _controller.user;
                                  return SmallTextCard(
                                      label: _controller
                                          .allFitnessGoals[index].goal,
                                      isSelected: user.goals!.contains(
                                          _controller
                                              .allFitnessGoals[index].goal),
                                      onTap: () {
                                        final item =
                                            _controller.allFitnessGoals[index];
                                        final selectedGoals = user.goals!;

                                        if (selectedGoals.contains(item)) {
                                          selectedGoals.remove(item);
                                        } else {
                                          if (selectedGoals.length >= 4) {
                                            return;
                                          }
                                          selectedGoals.add(item);
                                        }
                                      });
                                },
                              )),
                    ),
                    const SizedBox(
                      height: 10,
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
                      child: Text('MY WEIGHT IS…'),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 10),
                      child: Text('MY FAVORITE WORKOUTS ARE…'),
                    ),
                    Obx(() => _controller.myFavoriteWorkouts.isNotEmpty
                        ? GridView.count(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount:
                                (Get.width <= kWorkOutCardBreakWidth) ? 3 : 4,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 15.0,
                            crossAxisSpacing: 15.0,
                            children: [
                              ..._controller.myFavoriteWorkouts
                                  .map(
                                    (type) => WorkOutCard(
                                      imagePath: type.imagePath,
                                      title: type.title,
                                      onSelecte: () {},
                                      isSelected: false,
                                    ),
                                  )
                                  .toList(),
                            ],
                          )
                        : const SizedBox()),
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
