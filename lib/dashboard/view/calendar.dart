import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeCalendar extends StatefulWidget {
  const HomeCalendar({super.key, required this.school_year_start_date});
  final DateTime school_year_start_date;

  @override
  State<HomeCalendar> createState() => _HomeCalendarState();
}

class _HomeCalendarState extends State<HomeCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  @override
  void initState() {
    // TODO: implement initState
    _focusedDay = widget.school_year_start_date;
    _selectedDay = widget.school_year_start_date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 30,
      firstDay: widget.school_year_start_date.subtract(const Duration(days: 7)),
      lastDay: widget.school_year_start_date.add(const Duration(days: 365)),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.week,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
          _selectedDay = selectedDay;
        });
      },
      daysOfWeekVisible: false,
      calendarStyle: const CalendarStyle(),
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.secondary,
          ),
          rightChevronIcon: Icon(Icons.chevron_right,
              color: Theme.of(context).colorScheme.secondary)),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Center(
              child: Text(
            "${DateFormat.yMd().format(day)} - ${DateFormat.yMd().format(day.add(const Duration(days: 7)))}",
            style: Theme.of(context).textTheme.titleLarge,
          ));
        },
        prioritizedBuilder: (context, day, focusedDay) {
          return Stack(children: [
            if (isSameDay(day, focusedDay))
              Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
              ),
            Align(
                alignment: const Alignment(0, 0),
                child: Text(
                  DateFormat.E().format(day),
                  style: Theme.of(context).textTheme.titleLarge,
                ))
          ]);
        },
      ),
    );
  }
}
