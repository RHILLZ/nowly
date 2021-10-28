import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Configs/themes/app_colors.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widget_exporter.dart';

// ignore: must_be_immutable
class ScheduleCalendar extends GetView<SessionScheduleController> {
  ScheduleCalendar({Key? key, this.islnInFilters = false}) : super(key: key);

  final DateTime _toDay = DateTime.now();

  final bool islnInFilters;
  DateTime? _selectedTime;

  /// SAMPLE
  Widget hourMinute15Interval() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: kRegularTS.copyWith(color: kGray.withOpacity(0.5)),
      highlightedTextStyle: k20BoldTS,
      time: controller.selectedDateDetail.value.selectedTime,
      spacing: 10,
      itemHeight: 20,
      minutesInterval: 15,
      isForce2Digits: true,
      onTimeChange: (time) {
        _selectedTime = time;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.w(controller.selectedDateDetail.value.selectedDate);
    final kLastDay = DateTime(_toDay.year, _toDay.month, _toDay.day + 7);
    controller.selectedDay.value =
        controller.selectedDateDetail.value.selectedDate ?? _toDay;
    return Container(
        // elevation: 8,
        color: !islnInFilters ? Theme.of(context).cardColor : null,
        child: Padding(
          padding: const EdgeInsets.only(top: kScreenPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Schedule for later',
                style: k18BoldTS,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'training sessions can be scheduled\nup to one week in advance',
                textAlign: TextAlign.center,
                style: kRegularTS,
              ),
              const Text(
                'Day',
                style: k18BoldTS,
              ),
              Obx(
                () => TableCalendar(
                  availableGestures: AvailableGestures.none,
                  firstDay: _toDay,
                  lastDay: kLastDay,
                  focusedDay: controller.focusedDay.value,
                  daysOfWeekHeight: 40,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).dividerColor)))),
                  calendarStyle: CalendarStyle(
                    todayTextStyle: const TextStyle(),
                    todayDecoration: BoxDecoration(
                        color: kGray.withOpacity(0.1), shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    outsideTextStyle: const TextStyle(),
                  ),
                  calendarFormat: CalendarFormat.twoWeeks,
                  headerVisible: false,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.

                    return isSameDay(controller.selectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    AppLogger.i(controller.selectedDay.value);

                    controller.selectedDay.value = selectedDay;
                    controller.focusedDay.value = focusedDay;
                  },
                ),
              ),
              const Text(
                'Time',
                style: k18BoldTS,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Positioned(
                          top: -8,
                          right: 0,
                          left: 0,
                          child: hourMinute15Interval()),
                    ],
                  )),
              if (!islnInFilters)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RectButton(
                    onPressed: () {
                      controller.changeDate(date: controller.selectedDay.value);
                      controller.changeTime(time: _selectedTime);
                      Get.back();
                    },
                    title: 'APPLY',
                    isSelected: true,
                  ),
                )
            ],
          ),
        ));
  }
}
