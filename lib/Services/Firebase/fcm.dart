import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:nowly/Models/models_exporter.dart';

class FCM extends GetConnect {
  sendInPersonSessionSignal(Map<String, dynamic> session, String token) async {
    //TODO: SET CORRECT URL WHEN SERVER IS CONFIGURED
    var authority = "http://192.168.1.29:5888"; //Authority
    var path = '/sendInPersonSessionSignal'; //PATH TO SERVICE
    await httpClient.post(authority + path,
        body: json.encode({
          'session': session,
          'token': token
        })); // AWAIT HTTP POST {USER ID} for channel name
  }
}
