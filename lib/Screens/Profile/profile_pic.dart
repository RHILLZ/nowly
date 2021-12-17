import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class ProfileImageSetterScreen extends StatelessWidget {
  const ProfileImageSetterScreen({Key? key, required UserController controller})
      : _controller = controller,
        super(key: key);

  final UserController _controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
              title: Text(
                'Profile Image'.toUpperCase(),
                style: k16BoldTS,
              ),
              centerTitle: true),
          bottomSheet: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MainButton(
                  onTap: () {
                    _controller.chooseProfilePic();
                  },
                  title: 'Choose Image'.toUpperCase()),
              SizedBox(
                height: 2.h,
              ),
              MainButton(
                  onTap: () {
                    _controller.setProfileImage();
                  },
                  title: 'Set Profile Image'.toUpperCase()),
            ],
          ),
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 3.w),
              child: Center(
                  child: _controller.isLoadingPic
                      ? const CircularProgressIndicator.adaptive()
                      : GestureDetector(
                          child: ProfileImage(
                              imageFile: File(_controller.image.path),
                              imageURL: _controller.user.profilePicURL,
                              rad: 12),
                        ))),
        ));
  }
}
