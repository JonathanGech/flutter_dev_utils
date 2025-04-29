import 'package:flutter/material.dart';

class HoverOver extends StatefulWidget {
  const HoverOver({super.key, required this.builder});
  final Widget Function(bool isHovering) builder;

  @override
  State<HoverOver> createState() => _HoverOverState();
}

class _HoverOverState extends State<HoverOver> {
  bool isHovering = false;
  void setHovering(bool value) {
    setState(() {
      isHovering = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setHovering(true),
      onExit: (event) => setHovering(false),
      child: widget.builder(isHovering),
    );
  }
}
