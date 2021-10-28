import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class MedicalHistory extends StatelessWidget {
  MedicalHistory({Key? key, required RegistrationController controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;
  final TextEditingController _infoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MedicalHistoryQModel _medicalHistoryQModel =
        _controller.medicalHistoryQModel;
    return Obx(
      () => ExpandableCard(
        isFilled: _medicalHistoryQModel.filled,
        cardTitle: _medicalHistoryQModel.title,
        expanded:
            _controller.selectedQuestionnaire.value == _medicalHistoryQModel,
        content: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _medicalHistoryQModel.medicalQA.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: kContentGap,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final qa = _medicalHistoryQModel.medicalQA[index];
                    return Column(
                      children: [
                        Text(
                          qa().question,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 10, bottom: 20),
                          child: Obx(
                            () => Row(
                              children: [
                                Expanded(
                                    child: SmallTextCard(
                                        isSelected:
                                            qa().answer == yesNoAnswer.yes,
                                        label: 'Yes',
                                        onTap: () {
                                          qa.update((val) {
                                            val!.answer = yesNoAnswer.yes;
                                            _medicalHistoryQModel
                                                .toogleFilled();
                                          });
                                        })),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: SmallTextCard(
                                        isSelected:
                                            qa().answer == yesNoAnswer.no,
                                        label: 'No',
                                        onTap: () {
                                          qa.update((val) {
                                            val!.answer = yesNoAnswer.no;
                                            _medicalHistoryQModel
                                                .toogleFilled();
                                          });
                                        }))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          const Spacer(),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {
                                    _medicalHistoryQModel.makeAllNegative();
                                    _medicalHistoryQModel.toogleFilled();
                                  },
                                  child: const Text('No To All')))
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'you choose yes on one or more of the questions above, please specify:',
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextField(
                    controller: _infoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "insert info here...",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15)),
                    maxLines: 10,
                    minLines: 8,
                    onChanged: (v) {
                      _medicalHistoryQModel.info.value = v;
                      _medicalHistoryQModel.toogleFilled();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        onTapHeader: () {
          _controller.selectedQuestionnaire.value = _medicalHistoryQModel;
        },
      ),
    );
  }
}
