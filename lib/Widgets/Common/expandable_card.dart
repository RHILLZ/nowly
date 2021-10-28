import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';

class ExpandableCard extends StatelessWidget {
  ExpandableCard(
      {Key? key,
      required this.cardTitle,
      required this.content,
      required this.onTapHeader,
      required this.expanded,
      required this.isFilled})
      : super(key: key) {
    _controller.expanded = expanded;
  }

  final ExpandableController _controller = ExpandableController();
  final bool expanded;
  final String cardTitle;
  final RxBool isFilled;
  final Widget content;
  final VoidCallback onTapHeader;

  @override
  Widget build(BuildContext context) {
    //print('$expanded + $cardTitle');
    return Column(
      children: [
        ExpandableNotifier(
          // initialExpanded: expanded,
          controller: _controller,
          child: ScrollOnExpand(
            child: Ink(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: getExpandedCardBodyColor(context),
                  boxShadow: UIParameters.getShadow(
                      shadowColor: Get.theme.shadowColor.withOpacity(0.3))),
              child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    inkWellBorderRadius: BorderRadius.circular(20.0),
                    tapBodyToExpand: false,
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: false,
                    hasIcon: false,
                  ),
                  header: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      onTapHeader();
                      //_controller.expanded = !_controller.expanded;
                    },
                    child: Ink(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).cardColor,
                            boxShadow: UIParameters.getShadow(
                                shadowColor:
                                    Get.theme.shadowColor.withOpacity(0.3))),
                        height: 100,
                        child: Stack(
                          children: [
                            Center(child: Text(cardTitle, style: k16BoldTS)),
                            Obx(
                              () => Positioned(
                                  top: 0,
                                  bottom: 0,
                                  right: 20,
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    size: 40,
                                    color: isFilled.value
                                        ? kActiveColor
                                        : kLightGray,
                                  )),
                            )
                          ],
                        )),
                  ),
                  collapsed: ExpandableButton(
                    child: const SizedBox(),
                  ),
                  expanded: content),
            ),
          ),
        ),
      ],
    );
  }
}
