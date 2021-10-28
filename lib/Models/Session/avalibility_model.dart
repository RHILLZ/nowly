class AvailabilityModel {
  final String label;
  final String id;

  AvailabilityModel({
    required this.label,
    required this.id,
  });
  static final List<AvailabilityModel> availabilities = [
    AvailabilityModel(label: 'ONLINE', id: '1'),
    AvailabilityModel(label: 'BOOK LATER', id: '2'),
  ];
}
