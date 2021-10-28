import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:nowly/Models/models_exporter.dart';

class SessionServices extends GetConnect {
  Future<bool> findVirtualTrainer(
      String uid, String agoraToken, Map<String, dynamic> sessionData) async {
    bool _is200 = false;
    //TODO: SET CORRECT URL WHEN SERVER IS CONFIGURED
    String url = "http://192.168.1.29:5888/xdiVirtualMatch/$uid";
    final rep = await httpClient.post(url,
        body: jsonEncode(
            {'uid': uid, 'agoraToken': agoraToken, 'session': sessionData}));
    if (rep.statusCode == 200) {
      _is200 = true;
    }
    return _is200;
  }

  void findInPersonTrainer(
      String uid, String agoraToken, SessionModel session) async {
    //TODO: SET CORRECT URL WHEN SERVER IS CONFIGURED
    String url = "http://192.168.1.29:5888/xdiInPersonMatch/$uid";
    await httpClient.post(url,
        body: jsonEncode(
            {'uid': uid, 'agoraToken': agoraToken, 'session': session}));
  }

  findTrainerForScheduledSession(
      String uid, Map<String, dynamic> session) async {
    //TODO: SET CORRECT URL WHEN SERVER IS CONFIGURED
    String url = "http://192.168.1.29:5888/findTrainerForScheduledSession/$uid";
    await httpClient.post(url, body: jsonEncode(session));

    final res = await httpClient.get(url);
    final data = res.body as Map<String, dynamic>;

    return data['response'];
  }
}
