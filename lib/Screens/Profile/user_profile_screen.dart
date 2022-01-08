import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Nav/session_history_view.dart';
import 'package:nowly/Screens/Profile/info_screen.dart';
import 'package:nowly/Screens/Profile/profile_pic.dart';
import 'package:nowly/Screens/Stripe/add_payment_methods.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
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
        title: const Text('ACCOUNT'),
        actions: [
          IconButton(
              onPressed: () => Get.find<AuthController>().signOut(),
              icon: const Icon(Icons.logout))
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
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () => Get.to(ProfileImageSetterScreen(
                                  controller: controller)),
                              child: ProfileImage(
                                imageURL: controller.user.profilePicURL,
                              )),
                          SizedBox(
                            width: 3.w,
                          ),
                          Padding(
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
                                      EdgeInsets.only(top: 1.h, bottom: 1.h),
                                  child: Text(
                                    Get.find<MapController>().cityState,
                                    style: kRegularTS,
                                    maxLines: 4,
                                  ),
                                ),
                                Text(
                                    'Primary goal: ${controller.user.primaryGoal}'),
                                SizedBox(
                                  height: 1.h,
                                ),
                                RatingStars(rating: controller.user.rating)
                              ],
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
                // Get.to(() => MessagingScreen());
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
                Get.to(() => AddPaymentMethodsScreen());
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
