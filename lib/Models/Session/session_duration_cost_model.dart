class SessionDurationAndCostModel {
  final String duration;
  final int cost;
  final double? salesTax;
  final String? imagepath;
  String? motivationText;

  SessionDurationAndCostModel(
      {required this.duration,
      required this.cost,
      this.salesTax,
      this.imagepath,
      this.motivationText = ''});

  static final salesTaxByLoc = <String, dynamic>{
    'New York': .045,
  };

  static final List<SessionDurationAndCostModel> virtualSessionOptions = [
    SessionDurationAndCostModel(
        duration: '15MIN',
        cost: 3500,
        motivationText: 'QUICK AND NOT SO EASY',
        imagepath: 'assets/images/map/15min.svg'),
    SessionDurationAndCostModel(
        duration: '30MIN',
        cost: 5500,
        motivationText: 'I MEAN, IF THAT IS ALL YOU GOT',
        imagepath: 'assets/images/map/30min.svg'),
    SessionDurationAndCostModel(
        duration: '60MIN',
        cost: 11000,
        motivationText: 'OK SUPERSTAR WE SALUTE YOU!',
        imagepath: 'assets/images/map/60min.svg')
  ];

  static final List<SessionDurationAndCostModel> inPersonSessionOptions = [
    SessionDurationAndCostModel(
        duration: '30MIN',
        cost: 7000,
        motivationText: 'I MEAN, IF THAT IS ALL YOU GOT',
        imagepath: 'assets/images/map/30min.svg'),
    SessionDurationAndCostModel(
        duration: '60MIN',
        cost: 13000,
        motivationText: 'OK SUPERSTAR WE SALUTE YOU!',
        imagepath: 'assets/images/map/60min.svg')
  ];
}
