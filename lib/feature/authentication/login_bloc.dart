import 'dart:async';

import 'package:get/get.dart';
import 'package:new_flutter/feature/authentication/model/login_result.dart';
import 'package:rxdart/rxdart.dart';
import 'data/user_repository.dart';

class LoginBloc {
  final _userRepository = Get.find<UserRepository>();

  final _emailSubject = BehaviorSubject<String>.seeded('');
  final _passwordSubject = BehaviorSubject<String>.seeded('');
  final _loginStateSubject = BehaviorSubject<LoginBlocState>.seeded(LoginBlocState.invalid);

  Stream<String> get emailStream => _emailSubject.stream.transform(validateEmail);

  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream => _passwordSubject.stream.transform(validatePassword);

  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<LoginBlocState> get loginStateStream => _loginStateSubject.stream;

  Sink<LoginBlocState> get loginStateSink => _loginStateSubject.sink;

  LoginBloc() {
    CombineLatestStream.combine2(
      emailStream,
      passwordStream,
      (email, password) => email.contains('@') && password.length >= 2,
    ).listen((isValid) {
      loginStateSink.add(isValid ? LoginBlocState.valid : LoginBlocState.invalid);
    });
  }

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      sink.add(email);
      if (!email.contains('@') && email.isNotEmpty) {
        sink.addError('Invalid email');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      sink.add(password);
      if (password.length < 2 && password.isNotEmpty) {
        sink.addError('Password must be at least 2 characters');
      }
    },
  );

  Future<LoginResult> authenticate() async {
    loginStateSink.add(LoginBlocState.loading);
    final loginResult = await _userRepository.authenticate(
      email: _emailSubject.value,
      password: _passwordSubject.value,
    );
    loginStateSink.add(LoginBlocState.valid);
    return loginResult;
  }

  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
  }
}

enum LoginBlocState {
  valid,
  invalid,
  loading,
}
