import 'dart:convert';

import 'package:get/get_connect.dart';

class AgoraService extends GetConnect {
  generateAgoraToken(String channelName) async {
    //TODO: SET CORRECT URL WHEN SERVER IS CONFIGURED
    var authority = "http://192.168.1.29:5888"; //Authority
    var path = '/xdiAgoraTokenGenerator/$channelName'; //PATH TO SERVICE
    await httpClient.post(authority + path,
        body: json.encode({
          'channelName': channelName
        })); // AWAIT HTTP POST {USER ID} for channel name

    var response =
        await httpClient.get(authority + path); // AWAIT HTTP GET REQUEST
    var token = response.body;

    return token['token'];
    // DECODE JSON DATA {TOKEN, CHANNEL NAME, UID}
    // RETURN TOKEN AND CHANNEL NAME
  }
}
