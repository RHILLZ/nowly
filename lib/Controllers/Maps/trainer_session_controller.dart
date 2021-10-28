// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:nowly/Models/models_exporter.dart';
// import '../controller_exporter.dart';

// class TrainerSessionController extends GetxController {
//   // TrainerSessionController({required TrainerSessionModel trainerSessionModel}) {
//   //   trainerSession = trainerSessionModel;
//   // }

//   final selectedLength = SessionDurationAndCostModel(duration: '', cost: 0).obs;
//   late TrainerInPersonSessionModel trainerSession;
//   final showTimes = false.obs;

//   final sessionDistandeDuratiom = Rxn<Leg>();
//   final distanceAndDuraionText = Rxn<String>();
//   final distanceText = ''.obs;

//   void changeDistanceAndDuraion(Leg details) {
//     sessionDistandeDuratiom.value = details;
//     final text = '${details.duration.text} and ${details.distance.text} Away';
//     distanceAndDuraionText.value = text;
//     distanceText.value = details.distance.text;
//   }

//   void setTrainerDetails(TrainerInPersonSessionModel trainer) {
//     trainerSession = trainer;
//     selectedLength.duration = trainer.sessionLengths[0];
//   }

//   void openSessionDetailsBottomSheet() {
//     Get.bottomSheet(
//       Wrap(
//         children: [
//           SessionDetails(controller: this),
//         ],
//       ),
//       isScrollControlled: true,
//     );
//   }

//   void addOriginMarkerAndDrawPolyLinePath() {
//     MapController mapController = Get.find();
//     // ignore: unnecessary_null_comparison
//     if (trainerSession == null) return;
//     final LocationDetailsModel? locationDetails =
//         trainerSession.locationDetailsModel;
//     if (locationDetails == null) {
//       mapController.clearPolyLinePath();
//       return;
//     }
//     final location =
//         LatLng(locationDetails.latitude, locationDetails.longitude);
//     mapController.addOriginMarkers(location, tsController: this);
//   }

//   void changeTravelMode(TravelMode mode) {
//     MapController mapController = Get.find();
//     final LocationDetailsModel? locationDetails =
//         trainerSession.locationDetailsModel;

//     if (locationDetails != null) {
//       final location =
//           LatLng(locationDetails.latitude, locationDetails.longitude);
//       mapController.changeTravelMode(mode,
//           destination: location, tsController: this);
//     }
//   }
// }
