import 'package:dashboard_repository/dashboard_repository.dart';
import 'package:flutter/material.dart';

class PeriodCard extends StatefulWidget {
  const PeriodCard({super.key, required this.period});
  final Period period;

  @override
  State<PeriodCard> createState() => _PeriodCardState();
}

class _PeriodCardState extends State<PeriodCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 8, top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ID: ${widget.period.period_id}"),
          Text("Period: ${widget.period.period_en}"),
          Text("Start time: ${widget.period.start_time}"),
          Text("End time: ${widget.period.end_time}")
        ],
      ),
    );
  }
}
