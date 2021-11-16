import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class InjuryHistory extends StatelessWidget {
  const InjuryHistory({Key? key, required RegistrationController controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;

  @override
  Widget build(BuildContext context) {
    final InjuryHistoryQModel _injuryHistoryQModel =
        _controller.injuryHistoryQModel;
    return Obx(
      () => ExpandableCard(
        isFilled: _injuryHistoryQModel.filled,
        cardTitle: _injuryHistoryQModel.title,
        expanded:
            _controller.selectedQuestionnaire.value == _injuryHistoryQModel,
        content: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Do you have any pre-exsisting injuries we should know about?',
                    style: k16BoldTS,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallTextCard(
                          isSelected: !_injuryHistoryQModel.hasInjury,
                          label: 'No',
                          onTap: () {
                            _injuryHistoryQModel.hasInjury = false;
                            _injuryHistoryQModel.toogleFilled();
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      SmallTextCard(
                          isSelected: _injuryHistoryQModel.hasInjury,
                          label: 'Yes',
                          onTap: () {
                            _injuryHistoryQModel.hasInjury = true;
                            _injuryHistoryQModel.toogleFilled();
                          }),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          enabled: _injuryHistoryQModel.hasInjury,
                          border: const OutlineInputBorder(),
                          labelText: "Please explain...",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15)),
                      maxLines: 10,
                      minLines: 8,
                      onChanged: (v) {
                        _injuryHistoryQModel.injuryDetail = v;
                        _injuryHistoryQModel.toogleFilled();
                      },
                    ),
                  ),
                ],
              ),
            )),
        onTapHeader: () {
          _controller.selectedQuestionnaire.value == _injuryHistoryQModel
              ? _controller.selectedQuestionnaire.value =
                  QuestionnaireModel(title: '', header: '')
              : _controller.selectedQuestionnaire.value = _injuryHistoryQModel;
          _injuryHistoryQModel.toogleFilled();
        },
      ),
    );
  }
}
