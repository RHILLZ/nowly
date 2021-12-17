// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:nowly/Configs/configs.dart';
// import 'package:nowly/Models/models_exporter.dart';
// import 'package:sizer/sizer.dart';
// import '../widget_exporter.dart';

// class UserUpcomingSessionCard extends StatelessWidget {
//   const UserUpcomingSessionCard({Key? key, required SessionModel appointment})
//       : _appointment = appointment,
//         super(key: key);

//   final SessionModel _appointment;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _expand(context),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         elevation: 8,
//         child: Column(
//           children: [
//             Container(
//               child: Stack(
//                 alignment: Alignment.centerLeft,
//                 children: [
//                   Positioned(
//                     left: -6,
//                     child: FittedBox(
//                         fit: BoxFit.fill,
//                         child: CircleAvatar(
//                           radius: 7.h,
//                           child: _appointment.trainerProfilePicURL != null
//                               ? SvgPicture.asset('assets/icons/logo.svg')
//                               : null,
//                           foregroundImage: _appointment.trainerProfilePicURL !=
//                                   null
//                               ? NetworkImage(_appointment.trainerProfilePicURL!)
//                               : null,
//                         )),
//                   ),
//                   Positioned(
//                       top: 10,
//                       left: 30.w,
//                       child: Text(
//                         '${_appointment.trainerName}', // FROM APPOINTMENT MODEL
//                         style: k16BoldTS,
//                       )),
//                   Positioned(
//                       top: 35,
//                       left: 30.w,
//                       child: SizedBox(
//                         width: 40.w,
//                         child: Text(
//                           '${_appointment.sessionWorkoutType!} session', // FROM APPOINTMENT MODEL
//                           style: kRegularTS,
//                         ),
//                       )),
//                   Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                           margin: EdgeInsets.only(right: 20.w),
//                           child: const VerticalDivider(
//                               thickness: .5, color: Colors.black26))),
//                   Positioned(
//                       right: 3.w,
//                       child: Column(mainAxisSize: MainAxisSize.min, children: [
//                         Text(
//                           _appointment.futureSessionDate!
//                               .substring(0, 3)
//                               .toUpperCase(), // FROM APPOINTMENT MODEL
//                           style: k16BoldTS,
//                         ),
//                         Text(
//                           _appointment.futureSessionDate!
//                               .split(' ')[1], // FROM APPOINTMENT MODEL
//                           style: k16BoldTS,
//                         ),
//                         Text(
//                           _appointment
//                               .futureSessionTime!, // FROM APPOINTMENT MODEL
//                           style: k16BoldTS,
//                         )
//                       ])),
//                   Positioned(
//                       bottom: .5.h,
//                       left: 30.w,
//                       child: const CancelAppointmentButton())
//                 ],
//               ),
//               width: 90.w,
//               height: 12.h,
//               decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(20)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _expand(context) => Get.dialog(
//         Dialog(
//             // backgroundColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(kCardCornerRadius)),
//             insetPadding: const EdgeInsets.symmetric(horizontal: 15),
//             child: Container(
//               constraints: BoxConstraints(maxHeight: 40.h, minWidth: 80.w),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(kCardCornerRadius),
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     child: const Center(
//                       child: Text('Appointment Details',
//                           textAlign: TextAlign.center, style: kRegularTS),
//                     ),
//                     height: 4.h,
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(kCardCornerRadius),
//                           topRight: Radius.circular(kCardCornerRadius)),
//                     ),
//                   ),
//                   Container(
//                     child: Stack(
//                       alignment: Alignment.centerLeft,
//                       children: [
//                         Positioned(
//                             top: 0,
//                             // left: 20,
//                             child: CircleAvatar(
//                               radius: 6.h,
//                               child: _appointment.trainerProfilePicURL != null
//                                   ? SvgPicture.asset('assets/icons/logo.svg')
//                                   : null,
//                               foregroundImage:
//                                   _appointment.trainerProfilePicURL != null
//                                       ? NetworkImage(
//                                           _appointment.trainerProfilePicURL!)
//                                       : null,
//                             )),
//                         Positioned(
//                             top: 3.h,
//                             left: 30.w,
//                             child: Text(
//                               '${_appointment.trainerName}',
//                               style: k16BoldTS,
//                             )),
//                         // Positioned(
//                         //     top: 6.h,
//                         //     left: 30.w,
//                         //     child: SizedBox(
//                         //       width: 40.w,
//                         //       child: Column(
//                         //         children: [
//                         //           Text('data')
//                         //           Text(
//                         //             '${_appointment.sessionLocationName}', // FROM APPOINTMENT MODEL
//                         //             style: k10RegularTS,
//                         //           ),
//                         //         ],
//                         //       ),
//                         //     )),
//                         Align(
//                             alignment: Alignment.centerRight,
//                             child: Container(
//                                 margin: EdgeInsets.only(right: 20.w),
//                                 child: const VerticalDivider(
//                                     thickness: .5, color: Colors.black26))),
//                         Positioned(
//                             top: 3.h,
//                             right: 6.w,
//                             child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     _appointment.futureSessionDate!
//                                         .substring(0, 3)
//                                         .toUpperCase(), // FROM APPOINTMENT MODEL
//                                     style: k16BoldTS,
//                                   ),
//                                   Text(
//                                     _appointment.futureSessionDate!.split(
//                                         ' ')[1], // FROM APPOINTMENT MODEL
//                                     style: k16BoldTS,
//                                   ),
//                                   Text(
//                                     _appointment
//                                         .futureSessionTime!, // FROM APPOINTMENT MODEL
//                                     style: k10BoldTS,
//                                   )
//                                 ])),
//                         Positioned(
//                             // bottom: 12.h,
//                             right: 6.w,
//                             child: Column(
//                               children: [
//                                 SvgPicture.asset(
//                                   Get.isDarkMode
//                                       ? 'assets/images/trainer/durationIcon.svg'
//                                       : 'assets/images/trainer/lightTimeIcon.svg',
//                                   height: 5.h,
//                                 ),
//                                 SizedBox(
//                                   height: 1.h,
//                                 ),
//                                 Text(
//                                   _appointment.sessionDuration!,
//                                   style: k10BoldTS,
//                                 )
//                               ],
//                             )),
//                         Positioned(
//                             bottom: 2.h,
//                             right: 6.w,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 SvgPicture.asset(
//                                   _appointment.sessionWorkoutTypeImagePath!,
//                                   height: 5.h,
//                                 ),
//                                 SizedBox(
//                                   height: 1.h,
//                                 ),
//                                 Text(
//                                   _appointment.sessionWorkoutType!,
//                                   style: k10BoldTS,
//                                 )
//                               ],
//                             )),
//                         Positioned(
//                             bottom: 15.h,
//                             left: 6.w,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text('Location: '),
//                                 Text(
//                                   '${_appointment.sessionLocationName}',
//                                   style: k16BoldTS.copyWith(fontSize: 12),
//                                 ),
//                               ],
//                             )),
//                         Positioned(
//                             left: 6.w,
//                             bottom: 8.h,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Workout Type:',
//                                   style: kRegularTS,
//                                 ),
//                                 Text('${_appointment.sessionWorkoutType}',
//                                     style: k10RegularTS)
//                               ],
//                             )),
//                         Positioned(
//                             bottom: 8,
//                             left: 4.w,
//                             child: const CancelAppointmentButton())
//                       ],
//                     ),
//                     width: 100.w,
//                     height: 35.h,
//                     decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(kCardCornerRadius),
//                             bottomRight: Radius.circular(kCardCornerRadius))),
//                   )
//                 ],
//               ),
//             )),
//         barrierColor: Colors.black.withOpacity(.8),
//       );
// }
