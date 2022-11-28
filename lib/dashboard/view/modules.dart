import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../language/bloc/language_bloc.dart';
import '../../language/bloc/language_state.dart';
import '../repository/models/models.dart';

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
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.apps),
                    const SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Text(
                        state.locale == const Locale('vi')
                            ? e.fullname_vi
                            : e.fullname_en,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }).toList()
        ],
      ),
    );
  }
}
