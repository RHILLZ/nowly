import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/Net/net.dart';
import 'package:nowly/Utils/env.dart';
import 'package:nowly/Utils/logger.dart';
import '../controller_exporter.dart';

extension SearchPlaces on MapController {
  void registerSearchFunction() {
    debounce(searchQuery, (_) => onPlaceSearch(searchQuery.value),
        time: const Duration(milliseconds: 1000));
  }

  onPlaceSearch(String query) {
    isLoadingSearchedPlaces.value = true;
    final uri = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: '/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': query,
          'types': '(cities)',
          'key': GetPlatform.isIOS ? Env.iosMapsKey : Env.androidMapsKey
        });
    final net = Net.init('', uri: uri);
    net.onComplete = (http.Response response) {
      isLoadingSearchedPlaces.value = false;
      final PlaceAutoCompleteResponse result =
          placeAutoCompleteResponseFromJson(response.body);
      if (result.status == 'OK' || result.status == 'ZERO_RESULTS') {
        placeSearchResult.value = result.predictions;
      } else {
        //isFirstFetchParks = true;
      }
    };
    net.onError = (Exception e) {
      isLoadingSearchedPlaces.value = false;
      AppLogger.e(e);
    };
    net.execute();
  }

  void getPlaceDetails(PlacePrediction place) {
    isLoadingPlaceDetails.value = true;
    lastSearchedPlace.value = place;
    final uri = Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        path: '/maps/api/place/details/json',
        queryParameters: {
          'place_id': place.placeId,
          'key': GetPlatform.isIOS ? Env.iosMapsKey : Env.androidMapsKey
        });
    final net = Net.init('', uri: uri);
    net.onComplete = (http.Response response) {
      isLoadingPlaceDetails.value = false;
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == 'OK' ||
          responseBody['status'] == 'ZERO_RESULTS') {
        final place = Place.fromJson(responseBody['result']);
        animateCamera(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng));
      } else {
        //isFirstFetchParks = true;
      }
    };
    net.onError = (Exception e) {
      isLoadingPlaceDetails.value = false;
      AppLogger.e(e);
    };
    net.execute();
  }
}
