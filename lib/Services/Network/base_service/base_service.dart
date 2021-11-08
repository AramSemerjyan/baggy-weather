import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_weather/Helper/Logger/logger.dart';
import 'package:flutter_weather/Models/Result/request_result.dart';
import 'package:flutter_weather/Services/Network/Endpoints/endpoints.dart';
import 'package:http/http.dart' as http;

/// Here is my vision of Network Service (please don't be shocked... I know it's too good)
/// For cases when we should use token to access our backend I use additional
/// layer which called RefreshableService which extends BaseService and try
/// to make request with Access token. If it fails (401) then it try to retrieve
/// new Access token with Refresh token and recall failed request again
/// Don't have any queued mechanism because I'm not that smart and also because
/// My client doesn't have enough time for me to create an ideal Networking Service
/// (Who have a year to spend only for Networking, right?)

/// Here should be all other types of request
enum RequestType { get }

abstract class ContentType {
  static const String json = 'application/json';
  static const String formUrlEncoded = 'application/x-www-form-urlencoded';
}

abstract class BaseService {
  Future<RequestResult<dynamic>> make(RequestType type, EndPoint endpoint,
      {dynamic body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      String contentType = ContentType.json}) {
    dynamic jsonBody;

    if (body != null && contentType == ContentType.json) {
      jsonBody = json.encode(body);
    } else {
      jsonBody = body;
    }

    /// Logging every step of Networking to help myself debug any issue that can
    /// happen during development... I'm sure there would be a lot of issues
    printLog(title: 'Request body', content: jsonBody.toString());

    Uri uri;

    /// This is my use case for EndPoint object
    if (params != null && params.isNotEmpty) {
      params.removeWhere((key, value) => value == "null");
      uri = Uri.https(endpoint.base, endpoint.path, Map.from(params));
    } else {
      uri = Uri.https(endpoint.base, endpoint.path);
    }

    /// Still printing everything to make console as messy as possible
    printLog(title: 'Request URI', content: uri.toString());
    printLog(title: 'Request type', content: type.toString());

    Map allHeaders = {HttpHeaders.contentTypeHeader: contentType};

    if (headers != null) {
      allHeaders.addAll(headers);
    }

    /// We need headers also... I should be able to easily copy Access Token
    /// to make a cURL request in terminal to be sure that issue is from my code
    /// and is not server side
    printLog(title: 'Request Headers', content: allHeaders.toString());

    debugPrint(allHeaders.toString(), wrapWidth: 1024);

    Future result;

    /// Here ve
    switch (type) {
      case RequestType.get:
        result = http.get(uri, headers: Map.from(allHeaders));
        break;
    }

    return result.then((value) {
      final decoded = json.decode(utf8.decode(value.bodyBytes));
      printLog(title: 'Request Result', content: decoded.toString());

      if (value.statusCode >= 200 && value.statusCode < 300) {
        return RequestResult(data: decoded);
      } else {
        return RequestResult(error: "Something went wrong");
      }
    });
  }
}
