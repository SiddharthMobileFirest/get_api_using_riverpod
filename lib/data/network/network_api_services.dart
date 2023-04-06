import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../app_exception.dart';

class NetworkApiServices {
  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print("----------getApi-------------------- $url");
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      if (kDebugMode) {
        log(responseJson.toString());
      }
    } on SocketException {
      throw InterNetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print("----------PostApi-------------------$url");
      print("-----------data sended to post api ---------------------$data");
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      log(responseJson);
    } on SocketException {
      throw InterNetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataException(response.statusCode.toString());
    }
  }
}
