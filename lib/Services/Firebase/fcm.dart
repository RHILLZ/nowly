import 'dart:convert';
import 'package:get/get_connect.dart';
import 'package:nowly/Utils/env.dart';

class FCM extends GetConnect {
  final String baseURL = Env.apiBaseUrl;
  sendInPersonSessionSignal(Map<String, dynamic> session, String token) async {
    var authority = "$baseURL"; //Authority
    var path = '/sendInPersonSessionSignal'; //PATH TO SERVICE
    await httpClient.post(authority + path,
        body: json.encode({
          'session': session,
          'token': token
        })); // AWAIT HTTP POST {USER ID} for channel name
  }
}
