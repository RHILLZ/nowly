import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:sizer/sizer.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
      {Key? key, String? imageURL, double? rad = 6, File? imageFile})
      : _imageURL = imageURL,
        _rad = rad,
        _imageFile = imageFile,
        super(key: key);

  final String? _imageURL;
  final double? _rad;
  final File? _imageFile;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: kPrimaryColor, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: CircleAvatar(
          foregroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
          backgroundImage: _imageURL != null ? NetworkImage(_imageURL!) : null,
          child: _imageURL != null
              ? null
              : Icon(Icons.person,
                  size: 30.sp,
                  color: Get.isDarkMode ? null : const Color(0xFF15202E)),
          maxRadius: _rad!.h,
        ),
      ),
    );
  }
}
