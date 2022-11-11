import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/customTextInput.dart';
import '../login.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _rememberMe = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    context.read<LoginBloc>().add(TryAutoLogin());
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.message ?? "Authentication failure")),
            );
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Image(image: AssetImage('assets/SO.png')),
              const SizedBox(
                height: 20,
              ),
              _UsernameInput(),
              const SizedBox(
                height: 20,
              ),
              _PasswordInput(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [
                    Checkbox(
                        value: _rememberMe,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _rememberMe = val;
                            });
                          } else {
                            _rememberMe = true;
                          }
                        }),
                    Text(
                      locale.rememberMe,
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                  ]),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                      onPressed: null,
                      child: Text(
                        locale.forgotPassword,
                        style: TextStyle(color: Colors.red.shade300),
                      ))
                ],
              ),
              LoginButton(
                rememberMe: _rememberMe,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextInput(
          icon: Icon(
            Icons.lock_outline,
            color: Colors.grey.shade400,
          ),
          child: TextField(
            key: const Key('loginForm_usernameInput_textField'),
            onChanged: (username) =>
                context.read<LoginBloc>().add(LoginUsernameChanged(username)),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: locale.username,
              errorText: state.username.invalid ? 'invalid username' : null,
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextInput(
          icon: Icon(
            Icons.mail_outline,
            color: Colors.grey.shade400,
          ),
          child: TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginBloc>().add(LoginPasswordChanged(password)),
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: locale.password,
              errorText: state.password.invalid ? 'invalid password' : null,
            ),
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  bool rememberMe;
  LoginButton({required this.rememberMe});
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 40)),
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<LoginBloc>()
                            .add(LoginSubmitted(rememberMe: rememberMe));
                      }
                    : null,
                child: Text(locale.login),
              );
      },
    );
  }
}
