import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Screens/Nav/base_screen.dart';
import 'package:nowly/Screens/Sessions/feedback.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:nowly/Widgets/Common/profile_image.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:nowly/root.dart';
import 'package:sizer/sizer.dart';

class SessionCompleteScreen extends StatelessWidget {
  SessionCompleteScreen(
      {Key? key,
      required SessionModel session,
      required SessionController sessionController})
      : _session = session,
        _controller = sessionController,
        super(key: key);

  static const routeName = '/SessionComplete';
  final showMore = false.obs;
  final SessionController _controller;
  final SessionModel _session;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final sess = SessionModel().toMap(_session);
    AppLogger.i(sess);
    final _isIssue = false.obs;
    final _reviewSubmitted = false.obs;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(),
          title: const Text(
            'SESSION COMPLETE',
            style: k16BoldTS,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _controller.skip(_session, context);
                },
                child: const Text('Skip'))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
              padding: UIParameters.screenPadding,
              child: Obx(
                () => MainButton(
                    // enabled: false,
                    onTap: () async {
                      if (!_reviewSubmitted.value) {
                        await _controller.submitTrainerReview(_session);

                        await _controller.createSessionReceipt(_session);

                        _reviewSubmitted.value = true;

                        if (_isIssue.value) {
                          await _controller.reportIssue(_session, true);
                        }
                        Get.to(() => const FeedbackView());
                      } else {
                        Get.offAll(const Root());
                      }
                    },
                    title:
                        _reviewSubmitted.value ? 'GO HOME' : 'SUBMIT REVIEW'),
              )),
        ),
        body: Obx(() => _controller.isProcessing
            ? loadScreen()
            // : _reviewSubmitted.value
            //     ? thankYouView(context, _isUser)
            : SingleChildScrollView(
                padding: UIParameters.screenPadding,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: showMore.value ? 700 : 35.h,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(40.0),
                        onTap: () {
                          showMore.toggle();
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: getExpandedCardBodyColor(context),
                              boxShadow: UIParameters.getShadow()),
                          child: Padding(
                              padding: UIParameters.screenPadding,
                              child: Stack(
                                children: [
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: RoundedCornerButton(
                                        isSelected: true,
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                      )),
                                  Positioned.fill(
                                      child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ProfileImage(
                                          imageURL:
                                              _session.trainerProfilePicURL,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            _session.trainerName!,
                                            style: k20BoldTS.copyWith(
                                                fontSize: 25),
                                          ),
                                        ),
                                        Text(
                                          _session.sessionDuration!,
                                          style: k20BoldTS,
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          _session.sessionWorkoutType!
                                              .toUpperCase(),
                                          style: k16RegularTS,
                                        ),
                                        SizedBox(height: 1.h),
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              '${_session.sessionMode} Session'
                                                  .toUpperCase(),
                                              style: k16RegularTS),
                                        ),
                                        if (showMore.value)
                                          Expanded(
                                            child: SingleChildScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              child: Column(
                                                children: const [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Divider(
                                                    thickness: 2,
                                                  ),
                                                  // SessionCompleteDetails()
                                                ],
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  )),
                                ],
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text('HOW WAS YOUR SESSION ?', style: k20BoldTS),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: StarRatingBar(
                        size: 35,
                        rating: 0.0,
                        isRatable: true,
                        onRate: (value) {
                          _controller.calculateRating(value);
                          _controller.starRating = value;
                        },
                      ),
                    ),
                    _controller.starRating > .5
                        ? Text(_controller.rating.value, style: k20BoldTS)
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    _controller.starRating > 0.0
                        ? Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            alignment: WrapAlignment.center,
                            runSpacing: 10,
                            spacing: 10,
                            children: _controller.starRating < 3.0
                                ? negativeTrainerReviewList()
                                : positiveTrainerReviewList())
                        : Container(),
                    const SizedBox(height: 20),
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                      onTap: () {
                        if (_isIssue.value) {
                          _isIssue.value = false;
                        } else {
                          _isIssue.value = true;
                        }
                      },
                      title: const Text('REPORT AN ISSUE', style: k16RegularTS),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Obx(() =>
                        _isIssue.value ? buildReportTextField() : Container())
                  ],
                ),
              )));
  }

  Widget buildReportTextField() => Container(
        padding: const EdgeInsets.all(12),
        height: 25.h,
        width: 90.w,
        child: TextFormField(
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              labelText: 'Report Issue',
              hintText: 'please explain thee issue with your session here.'),
          maxLines: 10,
          onChanged: (val) => _controller.sessionIssueContext = val,
        ),
      );

  Widget loadScreen() => Center(
        child: SizedBox(
          height: 30.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator.adaptive(),
              SizedBox(
                height: 3.h,
              ),
              const Text(
                'Submitting Review...',
                style: k20BoldTS,
              )
            ],
          ),
        ),
      );

  Widget thankYouView(context, bool isUser) => Center(
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 30.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: getExpandedCardBodyColor(context),
              boxShadow: UIParameters.getShadow()),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(children: const [
              Text(
                'Thank you for your Feedback.',
                style: k20BoldTS,
              ),
            ]),
          ),
        ),
      );

  //LIST GENERATORs

  positiveTrainerReviewList() => List.generate(
        _controller.positiveTrainerReviewOptions.length,
        (index) => TextCard(
            label: _controller.positiveTrainerReviewOptions[index],
            isSelected: _controller.quickReviews
                .contains(_controller.positiveTrainerReviewOptions[index]),
            onTap: () {
              _controller.quickReviews
                      .contains(_controller.positiveTrainerReviewOptions[index])
                  ? _controller.quickReviews
                      .remove(_controller.positiveTrainerReviewOptions[index])
                  : _controller.quickReviews
                      .add(_controller.positiveTrainerReviewOptions[index]);
            }),
      );

  negativeTrainerReviewList() => List.generate(
        _controller.negativeTrainerReviewOptions.length,
        (index) => TextCard(
            label: _controller.negativeTrainerReviewOptions[index],
            isSelected: _controller.quickReviews
                .contains(_controller.negativeTrainerReviewOptions[index]),
            onTap: () {
              _controller.quickReviews
                      .contains(_controller.negativeTrainerReviewOptions[index])
                  ? _controller.quickReviews
                      .remove(_controller.negativeTrainerReviewOptions[index])
                  : _controller.quickReviews
                      .add(_controller.negativeTrainerReviewOptions[index]);
            }),
      );

  // positiveUserReviewList() => List.generate(
  //       _controller.positiveUserReviewOptions.length,
  //       (index) => TextCard(
  //           label: _controller.positiveUserReviewOptions[index],
  //           isSelected: _controller.quickReviews
  //               .contains(_controller.positiveUserReviewOptions[index]),
  //           onTap: () {
  //             _controller.quickReviews
  //                     .contains(_controller.positiveUserReviewOptions[index])
  //                 ? _controller.quickReviews
  //                     .remove(_controller.positiveUserReviewOptions[index])
  //                 : _controller.quickReviews
  //                     .add(_controller.positiveUserReviewOptions[index]);
  //           }),
  //     );
  // negativeUserReviewList() => List.generate(
  //       _controller.negativeUserReviewOptions.length,
  //       (index) => TextCard(
  //           label: _controller.negativeUserReviewOptions[index],
  //           isSelected: _controller.quickReviews
  //               .contains(_controller.negativeUserReviewOptions[index]),
  //           onTap: () {
  //             _controller.quickReviews
  //                     .contains(_controller.negativeUserReviewOptions[index])
  //                 ? _controller.quickReviews
  //                     .remove(_controller.negativeUserReviewOptions[index])
  //                 : _controller.quickReviews
  //                     .add(_controller.negativeUserReviewOptions[index]);
  //           }),
  //     );
}
