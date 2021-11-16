import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nowly/Models/models_exporter.dart';

class InjuryHistoryQModel extends QuestionnaireModel {
  InjuryHistoryQModel()
      : super(
            title: 'Injury History',
            header:
                'We hope you never broke anything...\n 💔(except for hearts) 💔 \n but if you did, we can help.');

  final RxString _injuryDetail = ''.obs;
  final RxBool _hasInjury = false.obs;

  get hasInjury => _hasInjury.value;
  get injuryDetail => _injuryDetail.value;

  set injuryDetail(value) => _injuryDetail.value = value;
  set hasInjury(value) => _hasInjury.value = value;

  @override
  void toogleFilled() {
    if (_hasInjury.value) {
      injuryDetail.isNotEmpty ? filled.value = true : filled.value = false;
      return;
    }
    filled.value = true;
  }
}
