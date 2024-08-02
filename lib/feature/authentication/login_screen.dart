import 'package:flutter/material.dart';
import 'package:new_flutter/navigation/router.dart';

import 'login_bloc.dart';
import 'model/login_result.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                StreamBuilder<String>(
                    stream: _loginBloc.emailStream,
                    builder: (context, snapshot) {
                      return TextField(
                        onChanged: (value) {
                          _loginBloc.emailSink.add(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          errorText: snapshot.hasError ? snapshot.error.toString() : null,
                        ),
                      );
                    }),
                const SizedBox(height: 16.0),
                TextField(
                  onChanged: (value) {
                    _loginBloc.passwordSink.add(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                StreamBuilder<LoginBlocState>(
                    stream: _loginBloc.loginStateStream,
                    builder: (context, snapshot) {
                      return LoginButton(
                        onPressed: _loginBloc.authenticate,
                        onLoginSuccess: () async {
                          context.goTo(AppRoute.profile);
                        },
                        isEnabled: snapshot.data == LoginBlocState.valid,
                        isLoading: snapshot.data == LoginBlocState.loading,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Future<LoginResult> Function() onPressed;
  final Future<void> Function() onLoginSuccess;
  final bool isEnabled;
  final bool isLoading;

  const LoginButton(
      {super.key,
      required this.onPressed,
      required this.isEnabled,
      required this.isLoading,
      required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled
          ? () async {
              final result = await onPressed();
              if (result is LoginFailure) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.error, maxLines: 1, overflow: TextOverflow.ellipsis),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (result is LoginSuccess) {
                await onLoginSuccess();
              }
            }
          : null,
      child: !isLoading ? const Text('Login') : Transform.scale(scale: 0.5, child: const CircularProgressIndicator()),
    );
  }
}
