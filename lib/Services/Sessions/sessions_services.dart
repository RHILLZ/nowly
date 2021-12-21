import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:nowly/Utils/logger.dart';

class SessionServices extends GetConnect {
  Future<bool> findVirtualTrainer(
      String uid, String agoraToken, Map<String, dynamic> sessionData) async {
    bool _is200 = false;
    //TODO: SET CORRECT URL WHEN SERVER IS CONFIGURED
    String url = "http://192.168.1.29:5888/xdiVirtualMatch/$uid";
    final req = await httpClient
        .post(url,
            body: jsonEncode(
                {'uid': uid, 'agoraToken': agoraToken, 'session': sessionData}))
        .then((value) => AppLogger.i(value.body));

    final response = await httpClient.get(url);
    AppLogger.i(response.statusCode);
    if (response.statusCode == 200) {
      _is200 = true;
    }

    return _is200;
  }
}
