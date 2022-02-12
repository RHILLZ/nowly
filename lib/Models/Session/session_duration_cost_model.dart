class SessionDurationAndCostModel {
  final String duration;
  final int cost;
  final double bookingFee;
  final double? salesTax;
  final String? imagepath;
  String? motivationText;

  SessionDurationAndCostModel(
      {required this.duration,
      required this.cost,
      required this.bookingFee,
      this.salesTax,
      this.imagepath,
      this.motivationText = ''});

  static final salesTaxByLoc = <String, dynamic>{
    'New York': .045,
  };

  static final List<SessionDurationAndCostModel> virtualSessionOptions = [
    SessionDurationAndCostModel(
        duration: '15MIN',
        cost: 3000,
        bookingFee: .019,
        motivationText: 'QUICK AND NOT SO EASY',
        imagepath: 'assets/images/map/15min.svg'),
    SessionDurationAndCostModel(
        duration: '30MIN',
        cost: 5000,
        bookingFee: 0.019,
        motivationText: 'I MEAN, IF THAT IS ALL YOU GOT',
        imagepath: 'assets/images/map/30min.svg'),
    SessionDurationAndCostModel(
        duration: '60MIN',
        cost: 10000,
        bookingFee: .019,
        motivationText: 'OK SUPERSTAR WE SALUTE YOU!',
        imagepath: 'assets/images/map/60min.svg')
  ];

  static final List<SessionDurationAndCostModel> inPersonSessionOptions = [
    SessionDurationAndCostModel(
        duration: '30MIN',
        cost: 6000,
        bookingFee: 0.019,
        motivationText: 'I MEAN, IF THAT IS ALL YOU GOT',
        imagepath: 'assets/images/map/30min.svg'),
    SessionDurationAndCostModel(
        duration: '60MIN',
        cost: 12000,
        bookingFee: .019,
        motivationText: 'OK SUPERSTAR WE SALUTE YOU!',
        imagepath: 'assets/images/map/60min.svg')
  ];
}
