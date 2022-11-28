// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:so/widgets/custom_switch_widget.dart';

void main() {
  testWidgets("CustomSwitch", (WidgetTester tester) async {
    bool value = false;
    Widget widget = CustomSwitch(
        value: value,
        leftText: "any",
        rightText: "any",
        onChanged: (val) {
          value = !value;
        });

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: widget),
    ));

    expect(find.byWidget(widget), findsOneWidget);
    expect(find.byKey(ValueKey('Switch_value_is_false')), findsOneWidget);
    await tester.tap(find.byWidget(widget));
    await tester.pumpAndSettle();
    expect(find.byKey(ValueKey('Switch_value_is_false')), findsOneWidget);
    expect(value, true);
  });
}
