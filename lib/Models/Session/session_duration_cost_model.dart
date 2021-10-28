class SessionDurationAndCostModel {
  final String duration;
  final int cost;
  final String? imagepath;
  String? charges;
  String? motivationText;

  SessionDurationAndCostModel(
      {required this.duration,
      required this.cost,
      this.charges,
      this.imagepath,
      this.motivationText = ''});

  static final List<SessionDurationAndCostModel> sessionOptions = [
    SessionDurationAndCostModel(
        duration: '15MIN',
        cost: 5000,
        motivationText: 'QUICK AND NOT SO EASY',
        imagepath: 'assets/images/map/15min.svg'),
    SessionDurationAndCostModel(
        duration: '30MIN',
        cost: 10000,
        motivationText: 'I MEAN, IF THAT IS ALL YOU GOT',
        imagepath: 'assets/images/map/30min.svg'),
    SessionDurationAndCostModel(
        duration: '60MIN',
        cost: 15000,
        motivationText: 'OK SUPERSTAR WE SALUTE YOU!',
        imagepath: 'assets/images/map/60min.svg')
  ];
}
