// import 'package:flutter/material.dart';
// import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
// import 'package:get/get.dart';
// import 'package:nowly/Configs/configs.dart';
// import 'package:nowly/Configs/themes/app_colors.dart';
// import 'package:nowly/Controllers/controller_exporter.dart';
// import 'package:nowly/Utils/logger.dart';
// import 'package:sizer/sizer.dart';
// import 'package:table_calendar/table_calendar.dart';

// import '../widget_exporter.dart';

// // ignore: must_be_immutable
// class ScheduleCalendar extends GetView<SessionScheduleController> {
//   ScheduleCalendar({Key? key, this.islnInFilters = false}) : super(key: key);

//   final DateTime _toDay = DateTime.now();

//   final bool islnInFilters;
//   DateTime? _selectedTime;

//   @override
//   final SessionScheduleController controller =
//       Get.put(SessionScheduleController());
//   final SessionController _sessionController = Get.find();

//   /// SAMPLE
//   Widget hourMinute15Interval() {
//     return TimePickerSpinner(
//       is24HourMode: true,
//       normalTextStyle: kRegularTS.copyWith(color: kGray.withOpacity(0.5)),
//       highlightedTextStyle: k20BoldTS,
//       time: controller.selectedDateDetail.value.selectedTime,
//       spacing: 10,
//       itemHeight: 20,
//       // itemWidth: 40.w,
//       minutesInterval: 30,
//       alignment: Alignment.center,
//       isForce2Digits: true,
//       onTimeChange: (time) {
//         _selectedTime = time;
//         final timeChecker = '${time.hour}.${time.minute}';
//         final ampm = time.hour >= 12 ? 'PM' : 'AM';
//         final hr = time.hour == 12 ? '12' : '${(time.hour % 12)}';
//         final formattedTime = '$hr:${time.minute} $ampm';
//         _sessionController.sessionTimeCheckerValue = double.parse(timeChecker);
//         _sessionController.sessionTimeScheduled = formattedTime;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppLogger.w(controller.selectedDateDetail.value.selectedDate);
//     final kLastDay = DateTime(_toDay.year, _toDay.month, _toDay.day + 7);
//     controller.selectedDay.value =
//         controller.selectedDateDetail.value.selectedDate ?? _toDay;
//     return Container(
//         // elevation: 8,
//         color: !islnInFilters ? Theme.of(context).cardColor : null,
//         child: Padding(
//           padding: const EdgeInsets.only(top: kScreenPadding),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Schedule In Person Session for later',
//                 style: k18BoldTS,
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               const Text(
//                 'In person training sessions can be scheduled\nup to one week in advance',
//                 textAlign: TextAlign.center,
//                 style: kRegularTS,
//               ),
//               const Text(
//                 'Day',
//                 style: k18BoldTS,
//               ),
//               Obx(
//                 () => TableCalendar(
//                   availableGestures: AvailableGestures.none,
//                   firstDay: _toDay,
//                   lastDay: kLastDay,
//                   focusedDay: controller.focusedDay.value,
//                   daysOfWeekHeight: 40,
//                   daysOfWeekStyle: DaysOfWeekStyle(
//                       decoration: BoxDecoration(
//                           border: Border(
//                               bottom: BorderSide(
//                                   width: 1,
//                                   color: Theme.of(context).dividerColor)))),
//                   calendarStyle: CalendarStyle(
//                     todayTextStyle: const TextStyle(),
//                     todayDecoration: BoxDecoration(
//                         color: kGray.withOpacity(0.1), shape: BoxShape.circle),
//                     selectedDecoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         shape: BoxShape.circle),
//                     outsideTextStyle: const TextStyle(),
//                   ),
//                   calendarFormat: CalendarFormat.twoWeeks,
//                   headerVisible: false,
//                   selectedDayPredicate: (day) {
//                     // Use `selectedDayPredicate` to determine which day is currently selected.
//                     // If this returns true, then `day` will be marked as selected.

//                     // Using `isSameDay` is recommended to disregard
//                     // the time-part of compared DateTime objects.

//                     return isSameDay(controller.selectedDay.value, day);
//                   },
//                   onDaySelected: (selectedDay, focusedDay) {
//                     final dow = {
//                       1: 'Monday',
//                       2: 'Tuesday',
//                       3: 'Wednesday',
//                       4: 'Thursday',
//                       5: 'Friday',
//                       6: 'Saturday',
//                       7: 'Sunday'
//                     };
//                     final mon = {
//                       1: 'JAN',
//                       2: 'FEB',
//                       3: 'MAR',
//                       4: 'APR',
//                       5: 'MAY',
//                       6: 'JUN',
//                       7: 'JUL',
//                       8: 'AUG',
//                       9: 'SEP',
//                       10: 'OCT',
//                       11: 'NOV',
//                       12: 'DEC'
//                     };
//                     AppLogger.i(controller.selectedDay.value);
//                     var abr = 'TH';
//                     if (selectedDay.day == 1 ||
//                         selectedDay.day == 21 ||
//                         selectedDay.day == 31) {
//                       abr = 'ST';
//                     }
//                     if (selectedDay.day == 2 || selectedDay.day == 22) {
//                       abr = 'ND';
//                     }
//                     if (selectedDay.day == 3 || selectedDay.day == 23) {
//                       abr = 'RD';
//                     }

//                     final date =
//                         '${mon[selectedDay.month]} ${selectedDay.day}$abr';
//                     final day = '${dow[selectedDay.weekday]}';
//                     _sessionController.sessionDateScheduled = date;
//                     _sessionController.sessionDay = day;
                   

//                     controller.selectedDay.value = selectedDay;
//                     controller.focusedDay.value = focusedDay;
//                   },
//                 ),
//               ),
//               const Text(
//                 'Time',
//                 style: k18BoldTS,
//               ),
//               Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   width: 50.w,
//                   height: 6.h,
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 2,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                           top: -8,
//                           right: 0,
//                           left: 0,
//                           child: hourMinute15Interval()),
//                     ],
//                   )),
//               if (!islnInFilters)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RectButton(
//                     onPressed: () {
//                       controller.changeDate(date: controller.selectedDay.value);
//                       controller.changeTime(time: _selectedTime);
//                       Get.back();
//                     },
//                     title: 'APPLY',
//                     isSelected: true,
//                   ),
//                 )
//             ],
//           ),
//         ));
//   }
// }
