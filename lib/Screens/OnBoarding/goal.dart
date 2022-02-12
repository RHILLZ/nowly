import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class Goal extends StatelessWidget {
  const Goal({Key? key, required RegistrationController controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;

  @override
  Widget build(BuildContext context) {
    final GoalsQModel _goalsQModel = _controller.goalsQModel;
    return Obx(
      () => ExpandableCard(
        isFilled: _goalsQModel.filled,
        cardTitle: _goalsQModel.title,
        expanded: _controller.selectedQuestionnaire.value == _goalsQModel,
        onTapHeader: () {
          _controller.selectedQuestionnaire.value == _goalsQModel
              ? _controller.selectedQuestionnaire.value =
                  QuestionnaireModel(title: '', header: '')
              : _controller.selectedQuestionnaire.value = _goalsQModel;
        },
        content: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('What are your fitness goals?', style: k16BoldTS),
                  const Text('(select up to 4)'),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: 6,
                      spacing: 6,
                      children: List.generate(
                          _goalsQModel.fitnessGoals.length,
                          (index) => Obx(
                                () => SmallTextCard(
                                    label: _goalsQModel.fitnessGoals[index],
                                    isSelected: _goalsQModel
                                        .selectedFitnessGoals
                                        .contains(
                                            _goalsQModel.fitnessGoals[index]),
                                    onTap: () {
                                      final item =
                                          _goalsQModel.fitnessGoals[index];
                                      final selectedGoal =
                                          _goalsQModel.selectedFitnessGoals;
                                      if (selectedGoal.contains(item)) {
                                        selectedGoal.remove(item);
                                      } else {
                                        if (selectedGoal.length >= 4) {
                                          return;
                                        }
                                        selectedGoal.add(item);
                                      }
                                      _goalsQModel.toogleFilled();
                                      _controller.isEveryRequirmentsFilled();
                                    }),
                              )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text('Do you have a time frame for your goals?',
                        textAlign: TextAlign.center, style: k16BoldTS),
                  ),
                  StringValueSlider(
                    currentSliderValue: _goalsQModel.selectedTimeFrameIndex,
                    onChange: (int i) {
                      _goalsQModel.toogleFilled();
                      _controller.isEveryRequirmentsFilled();
                    },
                    values: _goalsQModel.timeFrames,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text('What are your primary goal', style: k16BoldTS),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      runSpacing: 6,
                      spacing: 6,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                          _goalsQModel.primaryGoals.length,
                          (index) => Obx(
                                () => SmallTextCard(
                                    label: _goalsQModel.primaryGoals[index],
                                    isSelected: _goalsQModel
                                            .selectedPrimaryGoal.value ==
                                        _goalsQModel.primaryGoals[index],
                                    onTap: () {
                                      _goalsQModel.selectedPrimaryGoal.value =
                                          _goalsQModel.primaryGoals[index];
                                      _goalsQModel.toogleFilled();
                                      _controller.isEveryRequirmentsFilled();
                                    }),
                              )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
