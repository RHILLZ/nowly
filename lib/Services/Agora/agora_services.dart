import 'dart:convert';

import 'package:get/get_connect.dart';

class AgoraService extends GetConnect {
  generateAgoraToken(String channelName) async {
    var authority = "http://18.118.101.152"; //Authority
    var path = '/xdiAgoraTokenGenerator/$channelName'; //PATH TO SERVICE
    var response = await httpClient.post(authority + path,
        body: json.encode({
          'channelName': channelName
        })); // AWAIT HTTP POST {USER ID} for channel name

    var token = response.body;

    return token['token'];
  }
}
