import 'dart:convert';
import 'package:get/get_connect.dart';

class FCM extends GetConnect {
  sendInPersonSessionSignal(Map<String, dynamic> session, String token) async {
    var authority = "http://18.118.101.152"; //Authority
    var path = '/sendInPersonSessionSignal'; //PATH TO SERVICE
    await httpClient.post(authority + path,
        body: json.encode({
          'session': session,
          'token': token
        })); // AWAIT HTTP POST {USER ID} for channel name
  }
}
