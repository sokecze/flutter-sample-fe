import 'package:get/get.dart';
import 'package:new_flutter/feature/authentication/model/login_result.dart';
import 'package:new_flutter/feature/authentication/model/user.dart';

import '../../../shared/local_storage.dart';
import 'user_repository.dart';

class FakeUserRepository extends UserRepository {
  @override
  Future<LoginResult> authenticate({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = _FakeUsers.users.firstWhereOrNull(
      (user) => user.email == email,
    );

    if (user == null) {
      return const LoginFailure("User not found");
    } else {
      super.saveJwt(user.email);
      return LoginSuccess(user.email);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1));
    final jwt = await LocalStorage.getJwt();
    return _FakeUsers.users.firstWhereOrNull((user) => user.email == jwt);
  }
}

class _FakeUsers {
  static const users = [
    User(id: 1, email: "a@b.com"),
  ];
}
