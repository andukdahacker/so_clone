import 'package:dashboard_repository/dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ModulesCard extends StatelessWidget {
  const ModulesCard({super.key, required this.modules});
  final List<Modules> modules;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: const BoxDecoration(
          // border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        children: [
          ...modules.map((e) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.apps),
                Text(
                  e.fullname_en,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            );
          }).toList()
        ],
      ),
    );
  }
}
