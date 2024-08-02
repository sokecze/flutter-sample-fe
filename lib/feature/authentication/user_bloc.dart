import 'package:get/get.dart';
import 'package:new_flutter/feature/authentication/data/user_repository.dart';
import 'package:new_flutter/feature/authentication/model/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _userRepository = Get.find<UserRepository>();

  final _userStateSubject = BehaviorSubject<UserBlocState>.seeded(UserLoading());

  Stream<UserBlocState> get userBlocStream => _userStateSubject.stream;

  Sink<UserBlocState> get userBlocSink => _userStateSubject.sink;

  UserBloc() {
    getUser();
  }

  void getUser() async {
    final user = await _userRepository.getCurrentUser();
    user == null ? userBlocSink.add(UserLoggedOut()) : userBlocSink.add(UserLoaded(user: user));
  }

  Future<void> logOut() async {
    if (await _userRepository.cleanStorage()) {
      userBlocSink.add(UserLoggedOut());
    }
  }

  void dispose() {
    _userStateSubject.close();
  }
}

sealed class UserBlocState {
  const UserBlocState();
}

class UserLoaded extends UserBlocState {
  const UserLoaded({required this.user});

  final User user;
}

class UserLoading extends UserBlocState {}

class UserLoggedOut extends UserBlocState {}
