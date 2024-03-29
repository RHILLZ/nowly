import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';

class NameAndInfo extends StatelessWidget {
  NameAndInfo({Key? key, required RegistrationController controller})
      : _controller = controller,
        super(key: key);

  final RegistrationController _controller;
  final TextEditingController fNameTxtCon = TextEditingController();
  final TextEditingController lNameTxtCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _nameAndInfoQ = _controller.nameAndInfoQModel;
    final _filledToogle = _controller.nameAndInfoQModel.toogleFilled;

    int? inches = 3;
    int? inchesPoints = 0;
    return Obx(
      () => ExpandableCard(
        isFilled: _nameAndInfoQ.filled,
        cardTitle: _nameAndInfoQ.title,
        expanded: _controller.selectedQuestionnaire.value == _nameAndInfoQ,
        onTapHeader: () {
          _controller.selectedQuestionnaire.value == _nameAndInfoQ
              ? _controller.selectedQuestionnaire.value =
                  QuestionnaireModel(title: '', header: '')
              : _controller.selectedQuestionnaire.value = _nameAndInfoQ;
        },
        content: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 20),
            child: SeperatedColumn(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 2.h,
                );
              },
              children: [
                TextField(
                  controller: fNameTxtCon,
                  decoration: const InputDecoration(hintText: 'First Name'),
                  onChanged: (v) {
                    _nameAndInfoQ.firstName = v;
                    _filledToogle();
                    _controller.isEveryRequirmentsFilled();
                  },
                ),
                TextField(
                  controller: lNameTxtCon,
                  decoration: const InputDecoration(hintText: 'Last Name'),
                  onChanged: (v) {
                    _nameAndInfoQ.lastName = v;
                    _filledToogle();
                    _controller.isEveryRequirmentsFilled();
                  },
                ),
                Row(children: [
                  Expanded(
                      child: Obx(
                    () => DropDownBox(
                      title: 'Height (in.)',
                      value:
                          "${_nameAndInfoQ.height.truncate()}'${_nameAndInfoQ.height.toString().split('.')[1]} ",
                      onTap: () {
                        Get.bottomSheet(BottomSheetContent(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => NumberPicker(
                                value: _nameAndInfoQ.height.truncate(),
                                minValue: 3,
                                maxValue: 10,
                                step: 1,
                                haptics: true,
                                onChanged: (value) {
                                  inches = value;
                                  _nameAndInfoQ.height.value =
                                      double.parse('$inches.$inchesPoints');
                                },
                              ),
                            ),
                            const SizedBox(
                              child: Icon(
                                Icons.brightness_1,
                                size: 5,
                              ),
                            ),
                            Obx(
                              () => NumberPicker(
                                value: int.parse(_nameAndInfoQ.height
                                    .toString()
                                    .split('.')[1]),
                                minValue: 0,
                                maxValue: 9,
                                step: 1,
                                haptics: true,
                                onChanged: (value) {
                                  inchesPoints = value;
                                  _nameAndInfoQ.height.value =
                                      double.parse('$inches.$inchesPoints');
                                },
                              ),
                            ),
                          ],
                        )));
                      },
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Obx(
                    () => DropDownBox(
                      title: 'Weight (lbs.)',
                      value: _nameAndInfoQ.weight.toString(),
                      onTap: () {
                        Get.bottomSheet(BottomSheetContent(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => NumberPicker(
                                value: _nameAndInfoQ.weight.value,
                                minValue: 0,
                                maxValue: 500,
                                step: 1,
                                haptics: true,
                                onChanged: (value) {
                                  _nameAndInfoQ.weight.value = value;
                                  _controller.isEveryRequirmentsFilled();
                                },
                              ),
                            ),
                          ],
                        )));
                      },
                    ),
                  )),
                ]),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Obx(
                          () => DropDownBox(
                            title: 'Sex:',
                            value: _nameAndInfoQ.gender.value,
                            onTap: () {
                              Get.bottomSheet(Container(
                                color: Theme.of(context).cardColor,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    SeperatedColumn(
                                      children: [
                                        Obx(
                                          () => Container(
                                            color: _nameAndInfoQ.gender.value ==
                                                    'Male'
                                                ? kLightGray
                                                : null,
                                            child: ListTile(
                                              onTap: () {
                                                _nameAndInfoQ.gender.value =
                                                    'Male';
                                                _filledToogle();
                                                _controller
                                                    .isEveryRequirmentsFilled();
                                              },
                                              title: const Center(
                                                child: Text(
                                                  'Male',
                                                  style: k16BoldTS,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Container(
                                            color: _nameAndInfoQ.gender.value ==
                                                    'Female'
                                                ? kLightGray
                                                : null,
                                            child: ListTile(
                                              onTap: () {
                                                _nameAndInfoQ.gender.value =
                                                    'Female';
                                                _filledToogle();
                                                _controller
                                                    .isEveryRequirmentsFilled();
                                              },
                                              title: const Center(
                                                child: Text(
                                                  'Female',
                                                  style: k16BoldTS,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Container(
                                            color: _nameAndInfoQ.gender.value ==
                                                    'Other'
                                                ? kLightGray
                                                : null,
                                            child: ListTile(
                                              onTap: () {
                                                _nameAndInfoQ.gender.value =
                                                    'Other';
                                                _filledToogle();
                                                _controller
                                                    .isEveryRequirmentsFilled();
                                              },
                                              title: const Center(
                                                child: Text(
                                                  'Other',
                                                  style: k16BoldTS,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ));
                            },
                          ),
                        ))
                  ],
                ),
                Column(
                  children: [
                    CheckboxListTile(
                        activeColor: kPrimaryColor,
                        title: const Text(
                          'I confirm im at least 18 years old.',
                          style: k16BoldTS,
                        ),
                        value: _controller.isOver18,
                        selected: _controller.isOver18,
                        onChanged: (v) => _controller.isOver18 = v),
                    Visibility(
                      visible: _controller.isOver18,
                      child: const Text(
                        'What year were you born? \n Dont worry. we wont tell. Promise.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: _controller.isOver18,
                      child: Obx(() => Container(
                            constraints: BoxConstraints(maxHeight: 30.h),
                            child: YearPicker(
                                firstDate:
                                    DateTime(DateTime.now().year - 100, 1),
                                lastDate: DateTime(DateTime.now().year - 18, 1),
                                selectedDate: _nameAndInfoQ.birthYear.value,
                                onChanged: (value) {
                                  _nameAndInfoQ.birthYear.value = value;
                                  _filledToogle();
                                  _controller.isEveryRequirmentsFilled();
                                }),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
