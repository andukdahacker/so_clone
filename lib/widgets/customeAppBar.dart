import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final Widget? child;
  final AppBar appBar;

  const CustomAppBar(
      {super.key, required this.height, this.child, required this.appBar});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Widget? child = widget.child;
    return Stack(
      children: [
        //background
        SizedBox(
          width: double.infinity,
          height: widget.height,
          child: widget.appBar,
        ),

        if (child != null) child
      ],
    );
  }
}
