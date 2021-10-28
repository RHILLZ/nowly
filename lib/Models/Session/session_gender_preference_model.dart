class TrainerPreferenceModel {
  final String type;

  TrainerPreferenceModel({required this.type});
  static final List<TrainerPreferenceModel> trainerTypes = [
    TrainerPreferenceModel(type : 'NONE'),
    TrainerPreferenceModel(type : 'MALE'),
    TrainerPreferenceModel(type : 'FEMALE')
  ];
}
