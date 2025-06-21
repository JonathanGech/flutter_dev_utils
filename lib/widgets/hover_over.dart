import 'package:flutter/material.dart';

class HoverOver extends StatefulWidget {
  const HoverOver({super.key, required this.builder, this.cursor, this.onTap});
  final Widget Function(bool isHovering) builder;
  final MouseCursor? cursor;
  final void Function()? onTap;

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
      cursor: widget.cursor ?? MouseCursor.defer,
      onEnter: (event) => setHovering(true),
      onExit: (event) => setHovering(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: widget.builder(isHovering),
      ),
    );
  }
}
