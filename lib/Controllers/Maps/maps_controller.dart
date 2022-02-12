import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'dart:ui' as ui;

const kLocationLoadRadius = 2500;
const kmapZoomLevel = 15.0;

class MapController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() async {
    WidgetsBinding.instance!.addObserver(this);
    registerSearchFunction();
    super.onInit();
    initiateMyLocation();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance!.removeObserver(this);
    googleMapController.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _loadMapStyles();
    super.didChangePlatformBrightness();
  }

  final _darkMapStyle = '[]'.obs;
  final _lightMapStyle = '[]'.obs;

  LocationData?
      _originLocationData; //origin location when route/polyline drawing

  final destinationMarkers = <Marker>[].obs; //session locations for map markers
  final originMarker = Rxn<Marker>();
  Direction? direction; // rout direction, route length and time
  final polylinesPoints = <LatLng>[].obs; //route direction points
  TravelMode selectedTravelMode = TravelMode.driving; // driving or walking

  late GoogleMapController googleMapController;

  final CameraPosition initialPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: kmapZoomLevel,
  );

  final Location _location = Location(); // user location
  LocationData? get getOriginLocation => _originLocationData;

  //for map serch queries
  final searchQuery = ''.obs;
  final placeSearchResult = <PlacePrediction>[].obs;
  final lastSearchedPlace = Rxn<PlacePrediction>();
  final isLoadingSearchedPlaces = false.obs;
  final isLoadingPlaceDetails = false.obs;

  //for places , gtm park
  CameraPosition? camPosition;
  LocationData? _mapUserCenterPosition; // user location/position Data
  LocationData? get getmapUserCenterPosition => _mapUserCenterPosition;
  final showPlaceIcons = true.obs; // hide place icons when zoom out
  LatLng? lastMapCameraLocation; // last position map camera moved

  bool isFirstFetchGym = true;
  bool isFirstFetchParks = true;

  final placeMarkers = <Marker>[].obs; // gym and parks markers for map
  final List<Place> places = <Place>[];

  Future<void> onMapCreate(GoogleMapController controller) async {
    googleMapController = controller;
    await _loadMapStyles();
    getMyLocation();
  }

  Future<void> _loadMapStyles() async {
    _darkMapStyle.value =
        await rootBundle.loadString('assets/map_styles/map_dark_style.json');
    _lightMapStyle.value =
        await rootBundle.loadString('assets/map_styles/map_light_style.json');

    // ignore: use_build_context_synchronously
    final theme = WidgetsBinding.instance!.window.platformBrightness;
    if (theme == Brightness.dark) {
      googleMapController.setMapStyle(_darkMapStyle.value);
    } else {
      googleMapController.setMapStyle(_lightMapStyle.value);
    }
  }

  Future<void> getMyLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    //permissions
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _originLocationData = await _location.getLocation();

    if (_originLocationData != null) {
      animateCamera(
          target: LatLng(
              _originLocationData!.latitude ?? initialPosition.target.latitude,
              _originLocationData!.longitude ??
                  initialPosition.target.longitude));
    }

    _location.onLocationChanged.listen((l) {
      _originLocationData = l;
      _mapUserCenterPosition = l;
      _lat.value = l.latitude!;
      _lng.value = l.longitude!;
    });
  }

  void focusMe() async {
    if (_mapUserCenterPosition == null) {
      await getMyLocation();
    }
    animateCamera(
        target: LatLng(_mapUserCenterPosition!.latitude!,
            _mapUserCenterPosition!.longitude!));
  }

  void animateCamera({required LatLng target}) {
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: kmapZoomLevel),
      ),
    );
  }

  Future<void> changeTravelMode(TravelMode mode,
      {required LatLng destination,
      required TrainerInPersonSessionController tsController}) async {
    LocationData? myLocation = getOriginLocation;
    if (myLocation == null) {
      await getMyLocation();
      myLocation = getOriginLocation;
    }

    if (myLocation != null) {
      selectedTravelMode = mode;
      getDirectionDetails(
          origin: LatLng(myLocation.latitude!, myLocation.longitude!),
          destination: destination,
          onComplete: (direction) {
            if (direction != null) {
              tsController
                  .changeDistanceAndDuraion(direction.routes[0].legs[0]);
              return direction.routes[0].legs[0];
            }
          });
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //RLX ADDED CODE
  final _lat = 0.0.obs;
  final _lng = 0.0.obs;
  final _city = ''.obs;
  final _state = ''.obs;
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;
  final _myLocation = LocationData.fromMap({}).obs;

  get city => _city.value;
  get state => _state.value;
  get cityState => '$city, $state';

  // get myLocation => _myLocation.value;

  initiateMyLocation() async {
    _myLocation.value = await _location.getLocation();
    _lat.value = _myLocation.value.latitude!;
    _lng.value = _myLocation.value.longitude!;
    getCityAndState();
  }

  getCityAndState() async {
    final coords = await geo.placemarkFromCoordinates(_lat.value, _lng.value);
    var first = coords.first;
    _city.value = first.locality!;
    _state.value = first.administrativeArea!;
  }
}
