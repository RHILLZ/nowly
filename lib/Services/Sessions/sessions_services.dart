import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:nowly/Utils/logger.dart';

class SessionServices extends GetConnect {
  Future<bool> findVirtualTrainer(
      String uid, String agoraToken, Map<String, dynamic> sessionData) async {
    bool _is200 = false;
    String url = "http://18.118.101.152/xdiVirtualMatch/$uid";
    await httpClient
        .post(url,
            body: jsonEncode(
                {'uid': uid, 'agoraToken': agoraToken, 'session': sessionData}))
        .then((value) => AppLogger.i(value.body));

    final response = await httpClient.get(url);
    AppLogger.i('STATUS: ${response.statusCode}');

    if (response.statusCode == 200) {
      _is200 = true;
    }

    return _is200;
  }
}
