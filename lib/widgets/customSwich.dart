import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final Color? enableColor;
  final Color? disableColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;

  const CustomSwitch({
    super.key,
    this.enableColor,
    this.disableColor,
    this.width = 60,
    this.height = 35,
    this.switchHeight = 25,
    this.switchWidth = 25,
  });

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool value = false;

  Widget buildSwitch() {
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: value ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: widget.switchWidth,
        height: widget.switchHeight,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
        });
      },
      //switch container
      child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.white),
            color: value == false ? widget.disableColor : widget.enableColor,
          ),
          //switch
          child: Stack(children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 5),
                child: const Text("VI")),
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 5),
                child: const Text("EN")),
            buildSwitch()
          ])),
    );
  }
}
