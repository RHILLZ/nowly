import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nowly/Utils/app_logger.dart';

import 'end_points.dart';
import 'error_handler.dart';
import 'headers.dart';

const showCustomServerError = true;

// ignore: constant_identifier_names
enum HttpMethods { GET, POST, PUT, PATCH, DELETE }

class Net {
  static Map<String, Net> netWorkRequestsStack = {};

  Uri? _uri;
  Map<String, String>? _header;
  HttpMethods? _httpMethod;
  String? _url;
  Map<String, dynamic>? _queryParams;
  String? _contentType;

  late bool _authenticate;
  int? _autoRetryCount;
  bool _isAutoRetry = false;
  late int _timeOut;
  Map<String, dynamic>? _body;

  Function(http.Response response)? onComplete;
  Function(Exception)? onError;
  Function? onTimeOut;

  Net();

  Net.init(
    String url, {
    HttpMethods httpMethod = HttpMethods.GET,
    Map<String, String>? headers,
    bool authenticate = true,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    String contentType = "application/json",
    int timeOut = 5,
    int autoRetryCount = 0,
    bool isAutoRetry = false,
    Uri? uri,
  }) {
    _url = url;
    _header = headers;
    _authenticate = authenticate;
    _queryParams = queryParams;
    _contentType = contentType;
    _timeOut = timeOut;
    _httpMethod = httpMethod;
    _autoRetryCount = autoRetryCount;
    _isAutoRetry = isAutoRetry;
    _body = body;
    _uri = uri;
  }

//GET
  Future<void> _get() async {
    _httpMethod = HttpMethods.GET;

    try {
      _uri = _uri ?? _buildUri(url: _url, queryParams: _queryParams);
      AppLogger.info("url - $_httpMethod - ${_uri.toString()}");

      _header ??= await ReqHeaders().getHeader(_contentType);

      if (_authenticate) _pushToken(_header);

      if (_uri == null) throw Exception('Invalid URL argument');

      final response = await http
          .get(_uri!, headers: _header)
          .timeout(Duration(seconds: _timeOut), onTimeout: () {
        if (_isAutoRetry) {
          _autoRetry();
          return http.Response("TimeOut", 408);
        } else {
          if (onTimeOut != null) {
            onTimeOut!();
          }

          throw Exception("Time out - ${_uri.toString()}");
        }
      });

      if (response.statusCode == 408) return;

      //AppLogger.info('${response.body} ${response.statusCode}');

      final errorMessage = NetworkErrorHandler().handleRequest(response);
      if (errorMessage != null) throw errorMessage;

      _removeMeFromNetWorkRequestsStack();

      if (onComplete != null) {
        onComplete!(response);
      }
    } on Exception catch (error) {
      _addMeToNetWorkRequestsStack();
      AppLogger.error(error);
      if (onError != null) {
        onError!(error);
      }
    }
  }

  //POST
  Future _post() async {
    _httpMethod = HttpMethods.POST;

    try {
      _uri = _uri ?? _buildUri(url: _url, queryParams: _queryParams);
      AppLogger.info("url - $_httpMethod - ${_uri.toString()}");

      _header ??= await ReqHeaders().getHeader(_contentType);

      if (_authenticate) _pushToken(_header);

      if (_uri == null) throw Exception('Invalid URL argument');

      final response = await http
          .post(_uri!, headers: _header, body: json.encode(_body))
          .timeout(Duration(seconds: _timeOut), onTimeout: () {
        if (_isAutoRetry) {
          _autoRetry();
          return http.Response("TimeOut", 408);
        } else {
          if (onTimeOut != null) {
            onTimeOut!();
          }
          throw Exception("Time out - ${_uri.toString()}");
        }
      });

      if (response.statusCode == 408) return;

      AppLogger.info(response.body);
      final errorMessage = NetworkErrorHandler().handleRequest(response);
      if (errorMessage != null) throw errorMessage;

      _removeMeFromNetWorkRequestsStack();

      if (onComplete != null) {
        onComplete!(response);
      }
    } on Exception catch (error) {
      _addMeToNetWorkRequestsStack();
      AppLogger.error(error);
      if (onError != null) {
        onError!(error);
      }
    }
  }

  int _autoRetriedCount = 0;
  void _autoRetry() {
    _autoRetriedCount++;
    if (_autoRetriedCount == _autoRetryCount) {
      _isAutoRetry = false;
    }
    AppLogger.info("Auto retry count $_autoRetriedCount");
    execute();
  }

  void _addMeToNetWorkRequestsStack() {
    netWorkRequestsStack[_uri!.path] = this;
    AppLogger.info(
        "netWorkRequestsStack length ${netWorkRequestsStack.length}");
  }

  void _removeMeFromNetWorkRequestsStack() {
    netWorkRequestsStack.remove(_uri!.path);
  }

  Map<dynamic, dynamic>? _pushToken(Map? header) {
    // if (User.isLoggedIn)
    //   header!["token"] = User.serverToken;
    // else
    //   throw Exception("Login required"); // redirect to login
    //   return header;
  }

  Future<void> execute() async {
    switch (_httpMethod) {
      case HttpMethods.GET:
        await _get();
        break;
      case HttpMethods.POST:
        await _post();
        break;
      default:
      //await _get();
    }
  }

  static void resendFailedRequest() {
    netWorkRequestsStack.forEach((key, value) {
      value.execute();
    });
  }

  //build Uri
  Uri? _buildUri({String? url, Map<String, dynamic>? queryParams}) {
    if (_uri != null) {
      return _uri;
    }
    return Uri(
        scheme: ssl == true ? 'https' : 'http',
        host: host,
        port: port,
        path: url,
        queryParameters: queryParams);
  }
}
