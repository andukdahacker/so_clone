import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/authentication/authentication.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Align(
      alignment: const Alignment(0, -0.25),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Image(image: AssetImage('assets/SO.png')),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
              return Column(
                children: [
                  if (state.user.avatar.isNotEmpty)
                    CircleAvatar(
                      backgroundImage: NetworkImage(state.user.avatar),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("ID: ${state.user.id}"),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("${locale.fullName}: ${state.user.fullname}")
                ],
              );
            }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
              child: Text(locale.logout),
            ),
          ],
        ),
      ),
    );
  }
}
