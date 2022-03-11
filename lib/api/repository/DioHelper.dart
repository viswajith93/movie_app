import 'dart:core';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  Dio getDioInstance() {
    var dio = Dio();
    //_checkForCharlesProxy(dio);
    return dio;
  }

  void _checkForCharlesProxy(Dio dio) {
    const charlesIp = '192.168.100.23';
    if (charlesIp.isEmpty) return;
    debugPrint('#CharlesProxyEnabled');
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) => "PROXY $charlesIp:8888;";
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }
}
