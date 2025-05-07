import 'package:dev_utils/utils/custom_list_view_controller.dart';
import 'package:flutter/material.dart';

class CustomListViewBuilder extends StatefulWidget {
  final CustomListViewController controller;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double? itemHeight;
  final double? itemWidth;
  final Axis scrollDirection;
  final double viewportExtent;

  const CustomListViewBuilder({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.horizontal,
    this.viewportExtent = 0.0, // Default to 0.0 if not provided
    this.itemHeight = 100,
    this.itemWidth = 100,
  });

  @override
  State<CustomListViewBuilder> createState() => _CustomListViewBuilderState();
}

class _CustomListViewBuilderState extends State<CustomListViewBuilder> {
  @override
  void initState() {
    super.initState();
    widget.controller.setItemCount(
        count: widget.itemCount,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn);
    widget.controller.scrollController.addListener(_onScroll);

    // Schedule scroll check after first layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetToStart();
      _onScroll();
    });
  }

  void resetToStart() {
    widget.controller.scrollController.jumpTo(0.0);
  }

  void _onScroll() {
    final offset = widget.controller.scrollController.offset;
    final viewportWidth = widget.viewportExtent;
    final itemWidth = widget.itemWidth!;

    widget.controller.calculateVisibleItems(
      scrollOffset: offset,
      viewportExtent: viewportWidth,
      itemExtent: itemWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: widget.scrollDirection,
      controller: widget.controller.scrollController,
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }

  @override
  void dispose() {
    widget.controller.scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
