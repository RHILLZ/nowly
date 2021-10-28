class SessionModeModel {
  final String id;
  final String mode;

  SessionModeModel({required this.id, required this.mode});

  static final List<SessionModeModel> types = [
    SessionModeModel(id: '', mode: 'VIRTUAL'),
    SessionModeModel(id: '', mode: 'IN PERSON'),
  ];
}
