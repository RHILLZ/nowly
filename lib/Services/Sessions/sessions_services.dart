import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:nowly/Utils/env.dart';
import 'package:nowly/Utils/logger.dart';

class SessionServices extends GetConnect {
  final String baseURL = Env.apiBaseUrl;
  Future<bool> findVirtualTrainer(
      String uid, Map<String, dynamic> sessionData) async {
    bool _is200 = false;
    String url = "$baseURL/xdiVirtualMatch/$uid";
    var response = await httpClient.post(url,
        body: jsonEncode({'uid': uid, 'session': sessionData}));

    // final response = await httpClient.get(url);
    AppLogger.i('STATUS: ${response.statusCode}');

    if (response.statusCode == 200) {
      _is200 = true;
    }

    return _is200;
  }
}
