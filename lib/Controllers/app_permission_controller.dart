// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nowly/Configs/configs.dart';
// import 'package:permission_handler/permission_handler.dart';


// class AppPermissionController extends GetxController {
//   Future<bool> requestCameraPermission() async {
//     if (await Permission.camera.isGranted) {
//       return true;
//     }
//     if (await Permission.camera.isDenied) {
//       openCameraPermissionDialog();
//     }
//     return false;
//   }

//   openCameraPermissionDialog() async {
//     await Get.defaultDialog(
//         contentPadding: UIParameters.cardPadding,
//         title: 'Need Permission',
//         cancel: OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
//         confirm: OutlinedButton(
//             onPressed: () async {
//               await openAppSettings();
//               Get.back();
//             },
//             child: const Text(
//               'Open Settings',
//               style: TextStyle(color: kPrimaryColor),
//             )),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: const [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(Icons.qr_code_scanner_outlined),
//             ),
//             Text(
//               'This app need permission to use camera fetures. you can grant them in app settings.',
//               textAlign: TextAlign.center,
//             )
//           ],
//         ));
//   }

//   openLocationPermissionDialog() async {
//     await Get.defaultDialog(
//         contentPadding: UIParameters.cardPadding,
//         title: 'Need Permission',
//         cancel: OutlinedButton(
//             onPressed: () {
//               Get.back();
//             },
//             child: const Text('Cancel')),
//         confirm: OutlinedButton(
//             onPressed: () async {
//               await openAppSettings();
//               Get.back();
//             },
//             child: const Text(
//               'Open Settings',
//               style: TextStyle(color: kPrimaryColor),
//             )),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: const [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(Icons.location_off_rounded),
//             ),
//             Text(
//               'this app need permission to use location fetures. you can grant them in app settings.',
//               textAlign: TextAlign.center,
//             )
//           ],
//         ));
//   }
// }
