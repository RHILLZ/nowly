import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Sessions/scheduled_session_confirmation_screen.dart';
import 'package:nowly/Screens/Sessions/session_confirmation_screen.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

// class LocationSelectionView extends StatelessWidget {
//   const LocationSelectionView(
//       {Key? key, required MapController controller, required double radius})
//       : _controller = controller,
//         _radius = radius,
//         super(key: key);

//   final MapController _controller;
//   final double _radius;
//   @override
//   Widget build(BuildContext context) {
//     _controller.getParkLocationsList(_radius);
//     return Scaffold(
//         appBar: AppBar(title: const Text('Choose Location For Session')),
//         bottomSheet: SizedBox(
//             height: 10.h,
//             width: 100.w,
//             child: MainButton(onTap: () {
//               Get.find<SessionController>().sessionAvailability ==
//                       'book later'.toUpperCase()
//                   ? Get.to(() => ScheduledSessionConfirmationScreen())
//                   : Get.to(() => SessionConfirmationScreen());
//             })),
//         body: Obx(() => _controller.isLoading
//             ? loadScreen()
//             : Column(
//                 children: [
//                   // Expanded(flex: 1, child: GoogleMapWidget()),
//                   Expanded(
//                       flex: 2,
//                       child: LocationList(
//                         controller: _controller,
//                       ))
//                 ],
//               )));
//   }

//   loadScreen() => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Center(
//             child: CircularProgressIndicator(),
//           ),
//           SizedBox(height: 2.h),
//           const Text('Getting parks near you...', style: k20BoldTS)
//         ],
//       );
// }
