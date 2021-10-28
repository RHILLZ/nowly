// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

const String USERSCOLLECTION = 'xdi_users';
const String TRAINERSCOLLECTION = 'xdi_trainers';
const String USERSESSIONCOLLECTION = 'sessions';
const String REVIEWS = 'reviews';
const String FUTURESESSIONCOLLECTION = 'scheduled_sessions';
const String SESSIONCOLLECTION = 'xdi_sessions';
const String USERREPORTEDESSIONCOLLECTION = 'xdi_user_reported_sessions';
const String TRAINERREPORTEDESSIONCOLLECTION = 'xdi_trainer_reported_sessions';
const String SESSIONRECEIPTS = 'sessionReceipts';

SvgPicture VISAIMAGE = SvgPicture.asset(
  'assets/icons/payments/visa.svg',
  height: 2.h,
);
SvgPicture MASTERCARDIMAGE =
    SvgPicture.asset('assets/icons/payments/mastercard.svg', height: 5.h);

SvgPicture LOGOWTEXT = SvgPicture.asset(
  'assets/icons/logo.svg',
  height: 4.h,
);
