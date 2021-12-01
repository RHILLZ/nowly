import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Sessions/receipt_details_screen.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class SessionHistoryAndUpcomingView extends StatelessWidget {
  SessionHistoryAndUpcomingView({Key? key}) : super(key: key);
  final UserController _controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: 35.h,
            pinned: true,
            floating: true,
            centerTitle: true,
            snap: true,
            title: const Text(
              'UPCOMING SESSIONS',
              style: k16BoldTS,
            ),
            bottom: PreferredSize(
              preferredSize: Size(100.w, 10.h),
              child: Center(
                child: Container(
                  width: 100.w,
                  padding: const EdgeInsetsDirectional.all(15),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const Text(
                    'SESSION HISTORY',
                    style: k16BoldTS,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Visibility(
                          visible: _controller.scheduledSessions.isEmpty,
                          child: SvgPicture.asset(
                              'assets/images/appointments/emptysessions.svg'),
                        ),
                        Visibility(
                          visible: _controller.scheduledSessions.isEmpty,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 15),
                            child: Text(
                              'You have no upcoming appointments.',
                            ),
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            children: List.generate(
                                _controller.scheduledSessions.length,
                                (index) => Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.h, horizontal: 5.w),
                                      child: FittedBox(
                                        fit: BoxFit.fill,
                                        child: UserUpcomingSessionCard(
                                            appointment: _controller
                                                .scheduledSessions[index]),
                                      ),
                                    )),
                            onPageChanged: (index) {
                              _controller.visibleAppointIndex.value = index;
                            },
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                _controller.scheduledSessions.length,
                                (index) => Obx(
                                      () => IndicatorDot(
                                          selected: _controller
                                                  .visibleAppointIndex.value ==
                                              index),
                                    ))),
                        const SizedBox(
                          height: kToolbarHeight,
                        ),
                      ],
                    )),
              ),
            ),
          )
        ];
      },
      body: Ink(
        color: Theme.of(context).cardColor,
        child: Obx(
          () => _controller.sessionReceipts.isEmpty
              ? const Center(
                  child: Text(
                  'No session history to display.',
                  style: k16BoldTS,
                ))
              : ListView.separated(
                  shrinkWrap: true,
                  itemCount: _controller.sessionReceipts.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 0,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    var month = {
                      1: 'JAN',
                      2: 'FEB',
                      3: 'MAR',
                      4: 'APR',
                      5: 'MAY',
                      6: 'JUN',
                      7: 'JUL',
                      8: 'AUG',
                      9: 'SEP',
                      10: 'OCT',
                      11: 'NOV',
                      12: 'DEC',
                    };
                    final SessionReceiptModel _receipt =
                        _controller.sessionReceipts[index];
                    Timestamp time = _receipt.sessionTimestamp!;
                    final mo = month[time.toDate().month];
                    final day = '${time.toDate().day}TH';

                    return InkWell(
                      onTap: () {
                        Get.to(() => ReceiptDetailsScreen(receipt: _receipt));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: kScreenPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$mo $day'.toUpperCase(),
                                    style: kRegularTS,
                                  ),
                                  Text(
                                    '${_receipt.sessionMode} ${_receipt.sessionWorkoutType!}',
                                    style: kRegularTS,
                                  ),
                                  Text(
                                    _receipt.sessionDuration!,
                                    style: kRegularTS,
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${_receipt.sessionCharged}',
                              style: k20BoldTS,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    ));
  }
}
