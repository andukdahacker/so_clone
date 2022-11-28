import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../repository/models/models.dart';

class PeriodCard extends StatefulWidget {
  const PeriodCard({super.key, required this.period});
  final Period period;

  @override
  State<PeriodCard> createState() => _PeriodCardState();
}

class _PeriodCardState extends State<PeriodCard> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
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
          Text("${locale.period}: ${widget.period.period_en}"),
          Text("${locale.startTime}: ${widget.period.start_time}"),
          Text("${locale.endTime}: ${widget.period.end_time}")
        ],
      ),
    );
  }
}
