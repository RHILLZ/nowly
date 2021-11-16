import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

import 'onboarding_view.dart';

class StartScreenView extends GetView<AuthController> {
  StartScreenView({Key? key}) : super(key: key);
  final CarouselController _controller = CarouselController();
  final _current = 0.obs;

  @override
  Widget build(BuildContext context) {
    final List<String> _texts = [
      'Access Personal Trainers with a click of a button. 😌',
      'Schedule in person session at a public location with ease. 🗓',
      'Choose from a variety of training styles or just let us find your match. 🏃🏽‍♂️'
    ];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(gradient: onBoardingGradient(context)),
            child: Stack(
              children: [
                // Positioned.fill(
                //     child: SvgPicture.asset(
                //   'assets/images/onboarding/cover_image.svg',
                //   fit: BoxFit.scaleDown,
                // )),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0.h,
                    child: SafeArea(
                        //   child: Center(
                        //       child: AppLogo(
                        //     width: Get.width * 0.22,
                        //   )),
                        // ),
                        child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logo_outlined.svg',
                            height: 40.h,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: SvgPicture.asset(
                              'assets/icons/nowly.svg',
                              color: Colors.white,
                              height: 15.h,
                            ),
                          ),
                        ],
                      ),
                    ))),
                // Positioned(bottom: 5, right: 10, child: SkipButton())
              ],
            ),
          )),
          Padding(
            padding: UIParameters.screenPadding,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('On Demand Personal Training', style: k20BoldTS),
                  const SizedBox(height: 15),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 80.w),
                    child: CarouselSlider(
                      items: _texts
                          .map((e) => Text(e,
                              textAlign: TextAlign.center, style: k16TS))
                          .toList(),
                      options: CarouselOptions(
                          height: 10.h,
                          viewportFraction: 1.0,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 15),
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            _current.value = index;
                          }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _texts.asMap().entries.map((entry) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: IndicatorDot(
                              selected: _current.value == entry.key),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 100.w,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: getWidgetSelectedColor(context)),
                        onPressed: () {
                          Get.to(() => const OnBoardingView());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('GET STARTED',
                              style: k16BoldTS.copyWith(color: Colors.white)),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
