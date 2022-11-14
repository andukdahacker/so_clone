import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/authentication/authentication.dart';
import 'package:so/dashboard/view/view.dart';
import 'package:user_repository/user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'language/language.dart';
import 'login/view/view.dart';
import 'splash/splash.dart';

class App extends StatelessWidget {
  const App(
      {super.key,
      required this.authenticationRepository,
      required this.userRepository,
      required this.locale});

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider<LanguageBloc>(
            create: (context) =>
                LanguageBloc()..add(LanguageChanged(locale: locale)),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.locale,
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Colors.white,
              tertiary: Colors.grey.shade300,
            ),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              titleSmall: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              bodyMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              bodySmall: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          builder: (context, child) {
            // context.read<AuthenticationBloc>().add(AuthenticationFirstLoaded());
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      DashboardPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unknown:
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        );
      },
    );
  }
}
