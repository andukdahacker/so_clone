import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/dashboard/view/TrianglePainter.dart';
import 'package:so/dashboard/view/calendar.dart';
import 'package:so/dashboard/view/periods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../authentication/authentication.dart';
import '../bloc/dashboard_bloc.dart';

import '../bloc/dashboard_state.dart';
import 'modules.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDashboardHeader(context),
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
            if (state is DashboardSuccess) {
              var schoolYearStartDate = DateTime.fromMillisecondsSinceEpoch(
                  state.dashboard.school_year_start_date * 1000);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.periods,
                          style: textTheme.bodyLarge,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              locale.seeAll,
                              style: textTheme.titleSmall,
                            ))
                      ],
                    ),
                  ),
                  HomeCalendar(school_year_start_date: schoolYearStartDate),
                  CarouselSlider(
                    items: state.dashboard.period.map((e) {
                      return PeriodCard(period: e);
                    }).toList(),
                    options: CarouselOptions(
                        height: 150,
                        viewportFraction: 0.7,
                        padEnds: false,
                        enableInfiniteScroll: false),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: const Alignment(-0.5, 0),
                        child: CustomPaint(
                          painter: TrianglePainter(
                              strokeColor: Colors.white,
                              paintingStyle: PaintingStyle.fill),
                          child: const SizedBox(
                            height: 15,
                            width: 30,
                          ),
                        ),
                      ),
                      ModulesCard(modules: state.dashboard.modules),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(locale.generalModules),
                      ),
                      ModulesCard(modules: state.dashboard.general_modules),
                    ],
                  )
                ],
              );
            }
            if (state is DashboardError) {
              return const Text("error");
            }
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }),
        ],
      ),
    );
  }

  Widget buildDashboardHeader(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ListTile(
            leading:
                CircleAvatar(backgroundImage: NetworkImage(state.user.avatar)),
            title: Row(
              children: [
                Text(
                  locale.hello,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  state.user.fullname,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )
              ],
            ));
      },
    );
  }
}
