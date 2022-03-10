import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/Firebase/firebase_futures.dart';
import 'package:nowly/Utils/app_logger.dart';

class TrainerInPersonSessionModel {
  TrainerInPersonSessionModel(
      {required this.trainer,
      required this.sessionLengths,
      required this.locationDetailsModel});

  late TrainerModel trainer;
  final List<SessionDurationAndCostModel> sessionLengths;
  LocationDetailsModel locationDetailsModel;

  static Future<List<TrainerInPersonSessionModel>> getTrainers() async {
    // ignore: unused_local_variable
    final sessionOptions = SessionDurationAndCostModel.inPersonSessionOptions;
    AppLogger.info('GETTING TRAINERS FROM DB');
    List<TrainerInPersonSessionModel> trainers =
        await FirebaseFutures().getOnlineTrainers(sessionOptions);
    AppLogger.info('TRAINERS: $trainers');
    // <TrainerInPersonSessionModel>[
    //   TrainerInPersonSessionModel(
    //       trainer: TrainerModel(
    //           firstName: 'Nick', id: '1', lastName: 'Fury', rating: 4.5),
    //       sessionLengths: sessionOptions,
    //       locationDetailsModel: LocationDetailsModel(
    //           id: '1', longitude: -74.008825, latitude: 40.799308)),
    //   TrainerInPersonSessionModel(
    //       trainer: TrainerModel(
    //           firstName: 'Scarlett', id: '2', lastName: 'Witch', rating: 4.1),
    //       sessionLengths: sessionOptions,
    //       locationDetailsModel: LocationDetailsModel(
    //           id: '2', longitude: -73.9757, latitude: 40.8270)),
    //   TrainerInPersonSessionModel(
    //       trainer: TrainerModel(
    //           firstName: 'Tony', id: '3', lastName: 'Stark', rating: 4.9),
    //       sessionLengths: sessionOptions,
    //       locationDetailsModel: LocationDetailsModel(
    //           id: '3', longitude: -115.3037, latitude: 36.1896)),
    // ];

    return trainers;
  }
}
