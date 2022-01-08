import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models_exporter.dart';

class InPersonScheduledSessionModel {
  String? locationName;
  double? sessionTimeCheckValue;
  String? sessionFormattedTime;
  String? sessionDate;
  String? sessionDay;
  SessionDurationAndCostModel? sessionDurationAndCost;
  String? workoutTypeImagePath;
  String? workoutType;
  LatLng? location;

  InPersonScheduledSessionModel(
      {this.locationName,
      this.sessionTimeCheckValue,
      this.sessionFormattedTime,
      this.sessionDay,
      this.sessionDate,
      this.workoutType,
      this.sessionDurationAndCost,
      this.workoutTypeImagePath,
      this.location});

  static final dummyInPersonScheduleModel = InPersonScheduledSessionModel(
      locationName: 'James J. Braddock North Hudson County Park',
      location: const LatLng(40.8037, -74.0014),
      sessionFormattedTime: '5:30 PM',
      sessionTimeCheckValue: 17.3,
      sessionDay: 'WED',
      sessionDate: 'OCT 7TH',
      sessionDurationAndCost: SessionDurationAndCostModel(
          duration: '30MIN', cost: 1000, bookingFee: 0.019),
      workoutType: 'Boxing',
      workoutTypeImagePath: 'assets/images/workout/boxing.svg');
}
