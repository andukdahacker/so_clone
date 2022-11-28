import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final Color? enableColor;
  final Color? disableColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;
  final String? leftText;
  final String? rightText;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch(
      {super.key,
      this.enableColor,
      this.disableColor,
      this.width = 60,
      this.height = 35,
      this.switchHeight = 25,
      this.switchWidth = 25,
      this.leftText,
      this.rightText,
      required this.value,
      required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildSwitch() {
    return Container(
      margin: const EdgeInsets.all(4),
      alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
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
        widget.onChanged(!widget.value);
      },
      //switch container
      child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: Colors.white),
            color: widget.value == false
                ? widget.disableColor
                : widget.enableColor,
          ),
          //switch
          child: Stack(children: [
            if (widget.leftText != null && widget.value)
              Container(
                  key: const Key('Switch_value_is_true'),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(widget.leftText!)),
            if (widget.rightText != null && !widget.value)
              Container(
                  key: const Key("Switch_value_is_false"),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(widget.rightText!)),
            buildSwitch()
          ])),
    );
  }
}
