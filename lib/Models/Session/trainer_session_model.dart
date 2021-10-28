import '../models_exporter.dart';

class TrainerSessionModel {
  TrainerSessionModel(
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
  final SessionModeModel mode;
  LocationDetailsModel? locationDetailsModel;

  static Future<List<TrainerSessionModel>> getTrainers() async {
    // ignore: unused_local_variable
    final sampleLengths = [
      SessionDurationAndCostModel(
          duration: '15min',
          cost: 5000,
          imagepath: 'assets/images/map/15min.svg'),
      SessionDurationAndCostModel(
          duration: '30min',
          cost: 10000,
          imagepath: 'assets/images/map/30min.svg'),
      SessionDurationAndCostModel(
          duration: '60min',
          cost: 15000,
          imagepath: 'assets/images/map/60min.svg')
    ];

    final List<TrainerSessionModel> trainers = [];
    return trainers;
  }
}
