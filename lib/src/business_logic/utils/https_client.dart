import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

export 'https_client.dart' show HttpsClient, client;

class HttpsClient {
  static final HttpsClient _instance = HttpsClient._internal();
  final SecurityContext _securityContext = SecurityContext();
  static IOClient? _client;

  static IOClient get client {
    if (_client == null) {
      throw Exception("Client is not initialized yet.");
    }
    return _client!;
  }

  factory HttpsClient() {
    return _instance;
  }

  HttpsClient._internal();

  Future<void> init() async {
    // Add the first self-signed certificate
    var cert = await rootBundle.load('assets/certificates/certificate.crt');
    _securityContext.setTrustedCertificatesBytes(cert.buffer.asUint8List());

    _client = IOClient(HttpClient(context: _securityContext));
    debugPrint("https client init");
  }
}
