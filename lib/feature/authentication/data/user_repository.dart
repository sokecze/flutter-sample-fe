import 'package:new_flutter/feature/authentication/model/login_result.dart';
import 'package:new_flutter/feature/authentication/model/user.dart';
import 'package:new_flutter/shared/local_storage.dart';

abstract class UserRepository {
  Future<LoginResult> authenticate({required String email, required String password});

  Future<User?> getCurrentUser();

  void saveJwt(String jwt) {
    LocalStorage.saveJwt(jwt);
  }

  Future<String?> getJwt() {
    return LocalStorage.getJwt();
  }

  Future<bool> cleanStorage() {
    return LocalStorage.cleanStorage();
  }
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);
}
