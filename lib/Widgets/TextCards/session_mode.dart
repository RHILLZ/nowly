// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nowly/Configs/configs.dart';
// import 'package:nowly/Controllers/controller_exporter.dart';

// import '../widget_exporter.dart';

// class SessionMode extends StatelessWidget {
//   SessionMode({Key? key}) : super(key: key);

//   final SessionController _sessionController = Get.find();
//   final FilterController _filterController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: EdgeInsets.only(top: 25, bottom: 10),
//             child: Text(
//               'SESSION MODE',
//               style: k16BoldTS,
//             ),
//           ),
//         ),
//         FixedWidthContainer(
//           child: SeperatedRow(
//               separatorBuilder: (BuildContext context, int index) =>
//                   const SizedBox(
//                     width: kContentGap,
//                   ),
//               children: _sessionController.sessionModes
//                   .map((sessionMode) => Expanded(
//                         child: Obx(
//                           () => TextCard(
//                             isSelected: _sessionController.sessionMode.mode ==
//                                 sessionMode.mode,
//                             label: sessionMode.mode,
//                             onTap: () {
//                               if (_sessionController.sessionAvailability !=
//                                   'book later'.toUpperCase()) {
//                                 _sessionController.sessionMode = sessionMode;
//                                 _filterController.filteredSessionMode =
//                                     sessionMode;
//                               } else {
//                                 Get.snackbar('Invalid Action',
//                                     'Unable to book Virtual session for later. Scheduled sessions must be in person.',
//                                     snackPosition: SnackPosition.BOTTOM,
//                                     duration: const Duration(seconds: 4));
//                               }
//                             },
//                           ),
//                         ),
//                       ))
//                   .toList()),
//         )
//       ],
//     );
//   }
// }
