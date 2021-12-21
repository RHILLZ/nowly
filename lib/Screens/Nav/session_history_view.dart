import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Screens/Sessions/receipt_details_screen.dart';
import 'package:nowly/Widgets/Sessions/receipt_tile.dart';
import 'package:sizer/sizer.dart';

class SessionHistoryAndUpcomingView extends StatelessWidget {
  SessionHistoryAndUpcomingView({Key? key}) : super(key: key);
  final UserController _controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: const SizedBox(), preferredSize: Size(100.w, 5.h)),
        title: Text(
          'Session History'.toUpperCase(),
          style: k16BoldTS,
        ),
        centerTitle: true,
      ),
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
                  itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () => Get.to(() => ReceiptDetailsScreen(
                            receipt: _controller.sessionReceipts[index])),
                        child: ReceiptListTile(
                            receipt: _controller.sessionReceipts[index]),
                      )),
        ),
      ),
    );
  }
}
