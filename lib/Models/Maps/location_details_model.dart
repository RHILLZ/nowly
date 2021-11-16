class LocationDetailsModel {
  String id;
  final double longitude;
  final double latitude;
  String? locationDescription;
  String? locationIcon;

  LocationDetailsModel(
      {required this.id,
      required this.longitude,
      required this.latitude,
      this.locationDescription = 'Sample description abouth the session',
      this.locationIcon});
}
