

sealed class LoginResult {
  const LoginResult();
}

class LoginSuccess extends LoginResult {
  const LoginSuccess(String jwt);
}

class LoginFailure extends LoginResult {
  final String error;

  const LoginFailure(this.error);
}
