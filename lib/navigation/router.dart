import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:new_flutter/feature/authentication/login_screen.dart';
import 'package:new_flutter/feature/authentication/user_screen.dart';
import 'package:new_flutter/feature/conversation/conversation_screen.dart';
import 'package:new_flutter/shared/local_storage.dart';

enum AppRoute {
  login("/login"),
  profile("/profile"),
  messages("/messages"),
  ;

  const AppRoute(this.path);

  final String path;
}

final router = GoRouter(
  initialLocation: AppRoute.profile.path,
  routes: [
    GoRoute(
      path: AppRoute.login.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoute.profile.path,
      pageBuilder: (context, state) => const NoTransitionPage(child: UserScreen()),
      // builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
      path: AppRoute.messages.path,
      pageBuilder: (context, state) => const NoTransitionPage(child: ConversationScreen()),
      // builder: (context, state) => const MessageScreen(),
    ),
  ],
  redirect: (context, state) async {
    if (state.matchedLocation != AppRoute.login.path && await LocalStorage.getJwt() == null) {
      return AppRoute.login.path;
    } else {
      return null;
    }
  },
);

extension BuildContextExtension on BuildContext {
  void goTo(AppRoute appRoute) => go(appRoute.path);
}
