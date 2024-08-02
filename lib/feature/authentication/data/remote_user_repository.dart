import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_flutter/feature/authentication/data/user_repository.dart';
import 'package:new_flutter/feature/authentication/model/login_result.dart';
import 'package:new_flutter/feature/authentication/model/user.dart';
import 'package:new_flutter/shared/environment.dart';
import 'package:new_flutter/shared/http_utils.dart';

class RemoteUserRepository extends UserRepository {
  static final _environment = Get.find<Environment>();
  static final String _loginEndpoint = "${_environment.host}/login";
  static final String _userEndpoint = "${_environment.host}/currentuser";

  @override
  Future<LoginResult> authenticate({required String email, required String password}) async {
    final body = jsonEncode({"email": email, "password": password});
    http.Response response;
    try {
      response = await http.post(Uri.parse(_loginEndpoint), body: body, headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        HttpHeaders.acceptHeader: ContentType.json.toString()
      });
    } catch (e) {
      return LoginFailure("Server error: $e");
    }

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> tokenJson = jsonDecode(response.body);
        final token = tokenJson["token"];

        super.saveJwt(token);
        return LoginSuccess(token);
      } catch (e) {
        response.printToLog();
        return LoginFailure("Login error: $e");
      }
    } else {
      response.printToLog();
      return const LoginFailure("Login error");
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final jwt = await super.getJwt();
    if (jwt == null) return null;

    http.Response response;
    try {
      response = await http.get(Uri.parse(_userEndpoint), headers: {
        HttpHeaders.authorizationHeader: "Bearer $jwt",
      });
    } catch (e) {
      return null;
    }

    if (response.statusCode == 200) {
      try {
        final user = User.fromJson(jsonDecode(response.body));
        return user;
      } catch (e) {
        response.printToLogWithError("$e");
        return null;
      }
    } else {
      response.printToLog();
      return null;
    }
  }
}
