import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';

import '../widget_exporter.dart';

class PScore extends StatelessWidget {
  const PScore({Key? key, required RegistrationController controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;

  @override
  Widget build(BuildContext context) {
    final PscoreQModel _pscoreQM = _controller.pscoreQModel;

    return Obx(() => ExpandableCard(
        isFilled: _pscoreQM.filled,
        cardTitle: _pscoreQM.title,
        expanded: _controller.selectedQuestionnaire.value == _pscoreQM,
        content: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _pscoreQM.personalityQuestions.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: kContentGap,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final q = _pscoreQM.pscoreQA[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        q().question,
                        style: k16BoldTS,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    StringValueSlider(
                      currentSliderValue: q().answer,
                      onChange: (int i) {
                        q().answer.value = i;
                      },
                      values: _pscoreQM.answerOptions,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        onTapHeader: () {
          _controller.selectedQuestionnaire.value == _pscoreQM
              ? _controller.selectedQuestionnaire.value =
                  QuestionnaireModel(title: '', header: '')
              : _controller.selectedQuestionnaire.value = _pscoreQM;
          _pscoreQM.toogleFilled();
          _controller.isEveryRequirmentsFilled();
        }));
  }
}
