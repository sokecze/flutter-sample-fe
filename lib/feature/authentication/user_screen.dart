import 'package:flutter/material.dart';
import 'package:new_flutter/feature/authentication/model/user.dart';
import 'package:new_flutter/feature/authentication/user_bloc.dart';
import 'package:new_flutter/navigation/router.dart';
import 'package:new_flutter/navigation/ui/bottom_nav_bar.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _userBloc = UserBloc();

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<UserBlocState>(
            stream: _userBloc.userBlocStream,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case UserLoaded(user: User user):
                  return LoadedContent(id: user.id, email: user.email, onLogout: () async => await _userBloc.logOut());
                case UserLoggedOut():
                  context.goTo(AppRoute.login);
                  return const SizedBox.shrink();
                default:
                  return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
      bottomNavigationBar: BottomNavBar(
        context,
        currentIndex: 0,
      ),
    );
  }
}

class LoadedContent extends StatelessWidget {
  const LoadedContent({super.key, required this.id, required this.email, required this.onLogout});

  final int id;
  final String email;
  final Future<void> Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text("Basic information", style: Theme.of(context).textTheme.labelLarge),
          ),
          Text("ID", style: Theme.of(context).textTheme.titleLarge),
          Text("$id", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8.0),
          Text("Email", style: Theme.of(context).textTheme.titleLarge),
          Text(email, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8.0),
          Center(
              child: ElevatedButton(
                  onPressed: () async {
                    await onLogout();
                  },
                  child: const Text("Log out")))
        ],
      ),
    );
  }
}
