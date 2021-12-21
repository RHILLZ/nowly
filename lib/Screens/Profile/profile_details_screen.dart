import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class ProfileDetailsScreen extends GetView<UserController> {
  const ProfileDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/profileDetails';

  @override
  Widget build(BuildContext context) {
    var user = controller.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: UIParameters.screenPadding2,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight - kScreenPadding2 * 2),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileImage(
                      imageURL: controller.user.profilePicURL,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 20),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          '${user.firstName} ${user.lastName}'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: k16BoldTS,
                          maxLines: 4,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('PRIMARY GOAL', style: k16BoldTS),
                      trailing: Text(user.primaryGoal!, style: k16RegularTS),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      title: const Text('NO. OF SESSIONS', style: k16BoldTS),
                      trailing: Text('${user.sessionsCompleted}',
                          style: k16RegularTS),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      title: const Text('RATING', style: k16BoldTS),
                      trailing:
                          Text(user.rating.toString(), style: k16RegularTS),
                    ),
                    const Divider(height: 0),
                    // const ListTile(
                    //   title: Text('SESSION LENGTH', style: k16BoldTS),
                    //   // trailing: Text(user.sessionLength, style: k16RegularTS),
                    // ),
                    const Spacer(),
                    // Padding(
                    //   padding: UIParameters.screenPaddingHorizontal,
                    //   child: CustomOutLinedButton(
                    //     color: Theme.of(context).errorColor,
                    //     onPressed: () {},
                    //     title: 'DELETE ACCOUNT',
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kScreenPadding, vertical: 10),
                      child: CustomOutLinedButton(
                        color: getWidgetSelectedColor(context),
                        onPressed: () {
                          Get.find<AuthController>().signOut();
                          Get.back();
                        },
                        title: 'LOG OUT',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
