import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so/language/bloc/language_bloc.dart';
import 'package:so/language/bloc/language_event.dart';
import 'package:so/language/bloc/language_state.dart';
import 'package:so/widgets/customSwich.dart';
import 'package:so/widgets/customeAppBar.dart';
import '../login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool languageVI;

  @override
  void initState() {
    // TODO: implement initState
    var locale = context.read<LanguageBloc>().state.locale;
    if (locale == const Locale('vi')) {
      languageVI = true;
    } else {
      languageVI = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: Stack(children: [
          CustomAppBar(
              height: 230,
              appBar: AppBar(
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(locale.support)
                      ],
                    ),
                    BlocBuilder<LanguageBloc, LanguageState>(
                      builder: (context, state) {
                        return CustomSwitch(
                          value: languageVI,
                          onChanged: (val) {
                            setState(() {
                              languageVI = val;
                            });

                            if (languageVI) {
                              context.read<LanguageBloc>().add(
                                  const LanguageChanged(locale: Locale('vi')));
                            } else {
                              context.read<LanguageBloc>().add(
                                  const LanguageChanged(locale: Locale('en')));
                            }
                          },
                          width: 65,
                          leftText: "VI",
                          rightText: "EN",
                        );
                      },
                    )
                  ],
                ),
              )),
          BlocProvider(
            create: (context) {
              return LoginBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context))
                ..add(TryAutoLogin());
            },
            child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 100),
                child: const LoginForm()),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    locale.version,
                    style: textTheme.bodySmall,
                  ),
                  Text(
                    "2014-2021 Copyright OMT",
                    style: textTheme.bodySmall,
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
