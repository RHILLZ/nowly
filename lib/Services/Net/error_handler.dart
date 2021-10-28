import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:nowly/Utils/logger.dart';


class NetworkErrorHandler {
  NetworkErrorMessage? handleRequest(Response response) {
    final int statusCode = response.statusCode;
    NetworkErrorMessage? errorMessage;
    if (statusCode < 299) {
      return errorMessage;
    } else if (statusCode < 399) {
      //redirect error
      errorMessage = NetworkErrorMessage(response);
    } else if (statusCode < 499) {
      //Client
      errorMessage = NetworkErrorMessage(response);
    } else {
      //server error
      errorMessage = NetworkErrorMessage(response);
    }

    return errorMessage;
    //throw errorMessage;
  }
}

class NetworkErrorMessage extends IOException {
  NetworkErrorMessage(
    this.response, {
    this.statusCode,
    this.errorId,
    this.error,
  }) {
    decodeMessage(response);
  }

  String? statusCode;
  String? errorId;
  String? error;
  final Response response;

  @override
  String toString() {
    return "error - $error  statusCode - $statusCode path - ${response.request!.url}  ";
  }

  void decodeMessage(Response response) {
    Map<String, String>? decodeJson;
    try {
      decodeJson = json.decode(response.body) as Map<String, String>;
      statusCode = decodeJson["status_code"] ?? response.statusCode as String?;
      errorId = decodeJson["error_id"];
      error = decodeJson["error"];
    } catch (e) {
      AppLogger.e(e);
    }
  }
}
