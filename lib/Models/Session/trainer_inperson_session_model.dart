import 'package:nowly/Models/models_exporter.dart';

class TrainerInPersonSessionModel {
  TrainerInPersonSessionModel(this.id,
      {required this.trainer,
      required this.sessionLengths,
      required this.thumbNailImage,
      required this.isOnline,
      required this.mode,
      this.locationDetailsModel});

  late TrainerModel trainer;
  final List<SessionDurationAndCostModel> sessionLengths;
  final String thumbNailImage;
  final bool isOnline;
  final String id;
  final SessionModeModel mode;
  LocationDetailsModel? locationDetailsModel;

  static Future<List<TrainerInPersonSessionModel>> getTrainers() async {
    // ignore: unused_local_variable
    final sessionOptions = SessionDurationAndCostModel.sessionOptions;
    final trainers = <TrainerInPersonSessionModel>[];

    return trainers;
  }
}
