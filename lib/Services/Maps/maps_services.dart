import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsServices extends GetConnect {
  Future getListOfNearbyParks(LatLng location, double radius) async {
    const url = 'http://18.118.101.152/getNearbyLocations';
    await httpClient.post(url,
        body: jsonEncode({
          'lat': location.latitude,
          'lng': location.longitude,
          'radius': radius * 1600
        }));

    final response = await httpClient.get(url);
    final locations = response.body as Map<String, dynamic>;

    // print(locations['locations']);
    return locations['locations'];
  }
}
