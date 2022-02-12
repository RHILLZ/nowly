import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class UserInfoScreen extends StatelessWidget {
  UserInfoScreen({Key? key}) : super(key: key);

  static const routeName = '/info';
  // ignore: unused_field
  final ThemeController _themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;
    return Scaffold(
        appBar: AppBar(
          title: Text('Information'.toUpperCase()),
          centerTitle: true,
        ),
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     'assets/images/profile/lan.svg',
                      //     color: iconColor,
                      //   ),
                      //   title: const Text('LANGUAGE'),
                      //   trailing: const Icon(Icons.keyboard_arrow_right),
                      //   onTap: () {},
                      // ),
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     'assets/images/profile/pin.svg',
                      //     color: iconColor,
                      //   ),
                      //   title: const Text('CHANGE PIN'),
                      //   trailing: const Icon(Icons.keyboard_arrow_right),
                      //   onTap: () {},
                      // ),
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     'assets/images/profile/theme.svg',
                      //     color: iconColor,
                      //   ),
                      //   title: const Text('DARK MODE'),
                      //   trailing: CupertinoSwitch(
                      //     value: UIParameters.isDarkMode(context),
                      //     onChanged: (v) {
                      //       _themeController.changeTheme();
                      //     },
                      //     activeColor: getWidgetSelectedColor(context),
                      //   ),
                      // ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/images/profile/term_se.svg',
                          color: iconColor,
                        ),
                        title: const Text('TERMS & SERVICES'),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Get.find<AuthController>().loadDoc('nowlyTOS.pdf');
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/images/profile/privancy_p.svg',
                          color: iconColor,
                        ),
                        title: const Text('PRIVACY POLICY'),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Get.find<AuthController>().loadDoc('nowlyPA.pdf');
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          'assets/images/profile/contact.svg',
                          color: iconColor,
                        ),
                        title: const Text('CONTACT US'),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Dialogs().contactInfo(
                              context, Get.find<UserController>().emailNowly);
                        },
                      ),
                      // ListTile(
                      //   leading: SvgPicture.asset(
                      //     'assets/images/profile/faq.svg',
                      //     color: iconColor,
                      //   ),
                      //   title: const Text('FAQ'),
                      //   trailing: const Icon(Icons.keyboard_arrow_right),
                      //   onTap: () {},
                      // ),
                      const Spacer(),
                      Padding(
                        padding: UIParameters.screenPadding,
                        child: CustomOutLinedButton(
                          color: getWidgetSelectedColor(context),
                          onPressed: () {},
                          title: 'LOG OUT',
                        ),
                      )
                    ]),
                  )));
        })));
  }
}
