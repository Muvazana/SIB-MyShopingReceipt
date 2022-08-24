import 'dart:convert';
import 'dart:io';

import 'package:flutter_myshopingreceipt/const/general.dart';
import 'package:http/http.dart' as http;

class ServicesSuccess {
  int code;
  dynamic response;
  ServicesSuccess({
    required this.code,
    required this.response,
  });
}

class ServicesFailure {
  int code;
  dynamic errorResponse;
  ServicesFailure({
    required this.code,
    required this.errorResponse,
  });
}

class AppServices {
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<Object> baseService({
    required Uri url,
    Map<String, String>? headers = _headers,
    Object? body,
  }) async {
    try {
      var request = http.MultipartRequest("POST", url);
      request.files.add(
        await http.MultipartFile.fromPath(
          "files[]",
          body.toString(),
        ),
      );
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      if (response.statusCode == 201) {
        return ServicesSuccess(
          code: response.statusCode,
          response: json.decode(responsed.body),
        );
      }
      return ServicesFailure(
        code: response.statusCode,
        errorResponse: json.decode(responsed.body)['message'].toString(),
      );
    } on HttpException {
      return ServicesFailure(
          code: AppConst.CODE_NO_INTERNET_CONECCTION,
          errorResponse: "No Internet Connection");
    } on FormatException {
      return ServicesFailure(
          code: AppConst.CODE_INVALID_FORMAT, errorResponse: "Invalid Format");
    } catch (e) {
      return ServicesFailure(
          code: AppConst.CODE_UNKWON_ERROR, errorResponse: "Unknwon Error");
    }
  }
}
