import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:so/dashboard/view/TrianglePainter.dart';
import 'package:so/dashboard/view/calendar.dart';
import 'package:so/dashboard/view/periods.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../authentication/authentication.dart';
import '../bloc/dashboard_bloc.dart';

import '../bloc/dashboard_state.dart';
import 'modules.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          buildDashboardHeader(),
          BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
            if (state.status == DashboardStatus.success) {
              var schoolYearStartDate = DateTime.fromMillisecondsSinceEpoch(
                  state.dashboard!.school_year_start_date * 1000);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Periods",
                          style: textTheme.bodyLarge,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              "See all",
                              style: textTheme.titleSmall,
                            ))
                      ],
                    ),
                  ),
                  HomeCalendar(school_year_start_date: schoolYearStartDate),
                  CarouselSlider(
                    items: state.dashboard!.period.map((e) {
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
                      ModulesCard(modules: state.dashboard!.modules),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text("General modules"),
                      ),
                      ModulesCard(modules: state.dashboard!.general_modules),
                    ],
                  )
                ],
              );
            }
            if (state.status == DashboardStatus.failure) {
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

  Widget buildDashboardHeader() {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ListTile(
            leading:
                CircleAvatar(backgroundImage: NetworkImage(state.user.avatar)),
            title: Row(
              children: [
                const Text(
                  "Hi",
                  style: TextStyle(
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

  Widget buildCalendar(int school_year_start_date) {
    var date =
        DateTime.fromMillisecondsSinceEpoch(school_year_start_date * 1000);
    var _focusedDay = date;
    var _selectedDay = date;
    return TableCalendar(
      rowHeight: 20,
      firstDay: date.subtract(const Duration(days: 7)),
      lastDay: date.add(const Duration(days: 365)),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.week,
      daysOfWeekHeight: 18,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {},
      calendarStyle: const CalendarStyle(),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Center(
              child: Text(
                  "${DateFormat.yMd().format(day)} - ${DateFormat.yMd().format(day.add(const Duration(days: 7)))}"));
        },
        prioritizedBuilder: (context, day, focusedDay) {
          return const SizedBox();
        },
        dowBuilder: (context, day) {
          return Center(child: Text(DateFormat.E().format(day)));
        },
      ),
    );
  }
}
