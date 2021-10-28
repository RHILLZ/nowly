class SessionSortModel {
  final String label;

  SessionSortModel({required this.label});
  static final List<SessionSortModel> sessionSorts = [
    // SessionSortModel(label : 'RECOMMENDED'),
    SessionSortModel(label: 'DISTANCE'),
    SessionSortModel(label: 'RATING')
  ];
}
