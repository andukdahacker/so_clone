import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({super.key, required this.child, required this.icon});
  final Widget child;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        Expanded(child: icon),
        Expanded(
          flex: 5,
          child: child,
        )
      ]),
    );
  }
}
