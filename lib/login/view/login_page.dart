import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/widgets/customSwich.dart';
import 'package:so/widgets/customeAppBar.dart';
import '../login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

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
                      children: const [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Support")
                      ],
                    ),
                    const CustomSwitch()
                  ],
                ),
              )),
          BlocProvider(
            create: (context) {
              return LoginBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context));
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
                    "Version 2.3.0 - Teacher",
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
