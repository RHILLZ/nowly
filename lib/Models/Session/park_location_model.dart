import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkLocationModel {
  String parkName;
  LatLng parkLocation;

  ParkLocationModel({required this.parkName, required this.parkLocation});
}
