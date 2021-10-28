class LocationDetailsModel {
  final double longitude;
  final double latitude;
  final String id;
  String? locationDescription;
  String? locationIcon;

  LocationDetailsModel(
      {required this.longitude,
      required this.id,
      required this.latitude,
      this.locationDescription = 'Sample description abouth the session',
      this.locationIcon});
}

//40.746506, -73.986848