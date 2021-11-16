import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:sizer/sizer.dart';

class ExerciseHistory extends StatelessWidget {
  const ExerciseHistory({Key? key, required RegistrationController controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;

  @override
  Widget build(BuildContext context) {
    final ExerciseHistoryQModel _exerciseHQM =
        _controller.exerciseHistoryQModel;
    return Obx(
      () => ExpandableCard(
        isFilled: _exerciseHQM.filled,
        cardTitle: _exerciseHQM.title,
        expanded: _controller.selectedQuestionnaire.value == _exerciseHQM,
        content: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                const Text('How is your fitness level?', style: k16BoldTS),
                const SizedBox(
                  height: 15,
                ),
                SeperatedRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 2.w);
                  },
                  children: List.generate(
                      _exerciseHQM.fitnessLevels.length,
                      (index) => Expanded(
                            child: SmallTextCard(
                                isSelected: _exerciseHQM.fitnessLevels[index] ==
                                    _exerciseHQM.selectedFitnessLevel.value,
                                label: _exerciseHQM.fitnessLevels[index],
                                onTap: () {
                                  _exerciseHQM.selectedFitnessLevel.value =
                                      _exerciseHQM.fitnessLevels[index];
                                  _exerciseHQM.toogleFilled();
                                }),
                          )),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text('How many days a week do you want to work out',
                      style: k16BoldTS),
                ),
                StringValueSlider(
                  currentSliderValue: _exerciseHQM.selectedWorkOutIndex,
                  onChange: (int i) {
                    _exerciseHQM.toogleFilled();
                  },
                  values: _exerciseHQM.workOutDays,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text('have you worked with a coach or trainer before?',
                      style: k16BoldTS),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: SmallTextCard(
                            isSelected: _exerciseHQM.trainedWithACoach.value ==
                                yesNoAnswer.yes,
                            label: 'Yes',
                            onTap: () {
                              _exerciseHQM.trainedWithACoach.value =
                                  yesNoAnswer.yes;
                              _exerciseHQM.toogleFilled();
                            })),
                    const SizedBox(
                      width: kContentGap,
                    ),
                    Expanded(
                        child: SmallTextCard(
                            isSelected: _exerciseHQM.trainedWithACoach.value ==
                                yesNoAnswer.no,
                            label: 'No',
                            onTap: () {
                              _exerciseHQM.trainedWithACoach.value =
                                  yesNoAnswer.no;
                              _exerciseHQM.toogleFilled();
                            }))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text('if yes, how was it?', style: k16BoldTS),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                        _exerciseHQM.howWasItAnswers.length,
                        (index) => Obx(
                              () => SmallTextCard(
                                  label: _exerciseHQM.howWasItAnswers[index],
                                  isSelected: _exerciseHQM.howWasIt.value ==
                                      _exerciseHQM.howWasItAnswers[index],
                                  onTap: () {
                                    _exerciseHQM.howWasIt.value =
                                        _exerciseHQM.howWasItAnswers[index];
                                    _exerciseHQM.toogleFilled();
                                  }),
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTapHeader: () {
          _controller.selectedQuestionnaire.value == _exerciseHQM
              ? _controller.selectedQuestionnaire.value =
                  QuestionnaireModel(title: '', header: '')
              : _controller.selectedQuestionnaire.value = _exerciseHQM;
        },
      ),
    );
  }
}
