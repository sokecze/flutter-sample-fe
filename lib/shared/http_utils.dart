import 'dart:developer';

import 'package:http/http.dart';

extension HttpUtils on Response {
  void printToLog() {
    log("$statusCode: $body");
  }

  void printToLogWithError(String error) {
    log("$statusCode: $body, error: $error");
  }
}
