import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nowly/Controllers/controller_exporter.dart';


enum MapPlaceTypes { gym, park }

extension MapPlaces on MapController {
  // ignore: unused_element
  Future<void> fetchLocations({LatLng? mapCameraIdlePosition}) async {
    //final isEligible = isEligibleForFetchPlaces();
    // if (isEligible || isFirstFetchParks) {
    //   await fetchParks(mapCameraPosition: mapCameraIdlePosition);
    // }
    // if (isEligible || isFirstFetchGym) {
    //   await fetchGyms(mapCameraPosition: mapCameraIdlePosition);
    // }
    //fetch session data
  }

  onMapCameraMove(CameraPosition cam) {
    camPosition = cam;
    if (camPosition!.zoom < kmapZoomLevel - 3) {
      showPlaceIcons.value = false;
    } else {
      showPlaceIcons.value = true;
    }
  }

  onMapCameraIdle() {
    if (camPosition != null) {
      if (camPosition!.zoom >= kmapZoomLevel) {
        fetchLocations(mapCameraIdlePosition: camPosition!.target);
      }
    }
  }

  bool isEligibleForFetchPlaces() {
    final LocationData? userLocation = getmapUserCenterPosition;

    if (userLocation == null) return false;

    final LatLng? camLocation = camPosition != null
        ? camPosition!.target
        : LatLng(userLocation.latitude!, userLocation.latitude!);

    // ignore: prefer_conditional_assignment
    if (lastMapCameraLocation == null) {
      lastMapCameraLocation = camLocation;
    }

    final distanceBetWeenLastAndCurrentLocation = getDistanceBetweenLocations(
        camLocation!.latitude,
        camLocation.longitude,
        lastMapCameraLocation!.latitude,
        lastMapCameraLocation!.longitude);

    debugPrint('$distanceBetWeenLastAndCurrentLocation');

    if (distanceBetWeenLastAndCurrentLocation > kLocationLoadRadius / 2) {
      lastMapCameraLocation =
          LatLng(camLocation.latitude, camLocation.longitude);
      return true;
    }
    return false;
  }

  double getDistanceBetweenLocations(lat1, lon1, lat2, lon2) {
    // in meters
    const p = 0.017453292519943295;
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return (12742 * asin(sqrt(a))) * 1000;
  }

  //  Future<void> fetchGyms({LatLng? mapCameraPosition}) async {
  //   final mapUserCenterPosition = getmapUserCenterPosition;
  //   late LatLng mapCameraIdlePosiion;

  //   if (mapUserCenterPosition == null) {
  //     return;
  //   }
  //   if(mapCameraPosition != null){
  //     //when user move the google map
  //     mapCameraIdlePosiion =  LatLng(mapCameraPosition.latitude,mapCameraPosition.longitude);
  //   }else{
  //     mapCameraIdlePosiion = LatLng(mapUserCenterPosition.latitude!,mapUserCenterPosition.longitude!);
  //   }

  //   final uri = Uri(
  //       scheme: 'https',
  //       host: 'maps.googleapis.com',
  //       path: '/maps/api/place/nearbysearch/json',
  //       queryParameters: {
  //         'location': '${mapCameraIdlePosiion.latitude},${mapCameraIdlePosiion.longitude}',
  //         'radius': '$kLocationLoadRadius',
  //         'type': describeEnum(MapPlaceTypes.gym),
  //         'key': androidMapAPI
  //       });
  //   final net = Net.init('', uri: uri);
  //   net.onComplete = (http.Response response) {
  //     final Places responseBody = placeFromJson(response.body);
  //     if (responseBody.status == 'OK' || responseBody.status == 'ZERO_RESULTS') {
  //       _addGymsToMap(responseBody.results);
  //       isFirstFetchGym = false;
  //     } else {
  //       //isFirstFetchParks = true;
  //     }

  //     //places.addAll(placeFromJson(response.body).results);
  //   };
  //   net.onError = (Exception e) {
  //     AppLogger.e(e);
  //   };
  //   net.execute();
  // }

  // _addGymsToMap(List<Place> places) async {
  //   final List<Marker> markers = <Marker>[];
  //   for (Place place in places) {
  //     final Marker marker =
  //         await getPlaceMarkers(place, 'assets/images/map/map_gym.png');
  //     placeMarkers.add(marker);
  //   }
  //   placeMarkers.addAll(markers);
  // }

  // //parks

  // Future<void> fetchParks({LatLng? mapCameraPosition}) async {
  //  final mapUserCenterPosition = getmapUserCenterPosition;
  //   late LatLng mapCameraIdlePosiion;

  //   if (mapUserCenterPosition == null) {
  //     return;
  //   }
  //   if(mapCameraPosition != null){
  //     //when user move the google map
  //     mapCameraIdlePosiion =  LatLng(mapCameraPosition.latitude,mapCameraPosition.longitude);
  //   }else{
  //     mapCameraIdlePosiion = LatLng(mapUserCenterPosition.latitude!,mapUserCenterPosition.longitude!);
  //   }

  //   final uri = Uri(
  //       scheme: 'https',
  //       host: 'maps.googleapis.com',
  //       path: '/maps/api/place/nearbysearch/json',
  //       queryParameters: {
  //         'location':
  //             '${mapCameraIdlePosiion.latitude},${mapCameraIdlePosiion.longitude}',
  //         'radius': '$kLocationLoadRadius',
  //         'type': describeEnum(MapPlaceTypes.park),
  //         'key': androidMapAPI
  //       });
  //   final net = Net.init('', uri: uri);
  //   net.onComplete = (http.Response response) {
  //     final Places responseBody = placeFromJson(response.body);
  //     if (responseBody.status == 'OK' ||
  //         responseBody.status == 'ZERO_RESULTS') {
  //       _addParksToMap(responseBody.results);
  //       isFirstFetchParks = false;
  //     } else {
  //       //isFirstFetchParks = true;
  //     }
  //   };
  //   net.onError = (Exception e) {
  //     AppLogger.e(e);
  //   };
  //   net.execute();
  // }

  // _addParksToMap(List<Place> places) async {
  //   final List<Marker> markers = <Marker>[];
  //   for (Place place in places) {
  //     final Marker marker =
  //         await getPlaceMarkers(place, 'assets/images/map/map_park.png');
  //     placeMarkers.add(marker);
  //   }
  //   placeMarkers.addAll(markers);
  // }

  // Future<Marker> getPlaceMarkers(Place place, String image) async {
  //   final locations =
  //       LatLng(place.geometry.location.lat, place.geometry.location.lng);
  //   return Marker(
  //     markerId: MarkerId(place.placeId),
  //     infoWindow: InfoWindow(title: place.name),
  //     onTap: () {},
  //     position: locations,
  //     icon: BitmapDescriptor.fromBytes(await getBytesFromAsset(image, 60.sp.toInt())),
  //   );
  // }
}
