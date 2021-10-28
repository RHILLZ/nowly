import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Nav/session_history_view.dart';
import 'package:nowly/Screens/Profile/info_screen.dart';
import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

import 'my_goal_screen.dart';
import 'profile_details_screen.dart';

class UserProfileScreen extends GetView<UserController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  // ignore: avoid_field_initializers_in_const_classes
  final bool notifications = true;
  static const routeName = '/userProfile';

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedCornerButton(
              onTap: () {},
              child: (UIParameters.isDarkMode(context))
                  ? Image.asset(notifications
                      ? 'assets/images/profile/notifications_w.png'
                      : 'assets/images/profile/notifications_empty_w.png')
                  : Image.asset(notifications
                      ? 'assets/images/profile/notifications.png'
                      : 'assets/images/profile/notifications_empty.png'),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (controller.isUserAvailable.value)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  kScreenPadding, 8, kScreenPadding, kScreenPadding),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  // Get.toNamed(ProfileDetailsScreen.routeName);
                  Get.to(const ProfileDetailsScreen());
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(controller.user.profilePicURL),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${controller.user.firstName} ${controller.user.lastName}',
                                  style: k20RegularTS,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 3),
                                  child: Text(
                                    Get.put(MapController()).cityState,
                                    style: kRegularTS,
                                    maxLines: 4,
                                  ),
                                ),
                                Text(controller.user.primaryGoal),
                                SizedBox(
                                  height: 1.h,
                                ),
                                RatingStars(rating: controller.user.rating)
                              ],
                            ),
                          ),
                        ),
                        // SvgPicture.asset(
                        //   controller
                        //       .userModel!.myPrimaryFitnessGoals.imagePath,
                        //   color: Theme.of(context).iconTheme.color,
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 15),
              child: Text(
                'ACCOUNT SETTINGS',
                style: kRegularTS,
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => SessionHistoryAndUpcomingView());
              },
              leading: SvgPicture.asset(
                'assets/images/profile/appoinments.svg',
                color: iconColor,
              ),
              title: Text('Session History'.toUpperCase()),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () {
                Get.to(() => UserInfoScreen());
              },
              leading: SvgPicture.asset(
                'assets/images/profile/preferences.svg',
                color: iconColor,
              ),
              title: Text('Information'.toUpperCase()),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () {
                Get.to(() => MyGoalScreen());
              },
              leading: SvgPicture.asset(
                'assets/images/profile/goal.svg',
                color: iconColor,
              ),
              title: const Text('GOALS'),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () {
                Get.toNamed(AddPaymentMethodsScreen.routeName);
              },
              leading: SvgPicture.asset(
                'assets/images/profile/payment.svg',
                color: iconColor,
              ),
              title: const Text('PAYMENT'),
              trailing: const Icon(Icons.keyboard_arrow_right),
            )
          ],
        ),
      ),
    );
  }
}
