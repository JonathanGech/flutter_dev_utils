import 'package:dev_utils/utils/navigation_item_model.dart';
import 'package:dev_utils/widgets/hover_over.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SideNavigationBar extends StatefulWidget {
  const SideNavigationBar({
    super.key,
    this.backgroundNavigationColor = const Color(0xFF0e0e2c),
    this.wholePadding = const EdgeInsets.only(left: 18, right: 18, top: 20),
    this.srcImage =
        'https://plus.unsplash.com/premium_photo-1688350808212-4e6908a03925?q=80&w=1469&auto=format&fit=crop',
    this.expandedWidth = 200,
    this.collapsedWidth = 80,
    this.animationDuration = const Duration(milliseconds: 300),
    required this.items,
    this.middleWidget,
    this.bottomColor = const Color(0xFF94A3B8),
    this.topWidget,
    this.name = 'Emily John',
    this.postion = 'Admin',
    this.bottomWidget,
    this.nameStyle,
    this.positionStyle,
  });

  final Color? backgroundNavigationColor;
  final Color? bottomColor;
  final EdgeInsets wholePadding;
  final String? srcImage;
  final double expandedWidth;
  final double collapsedWidth;
  final Duration animationDuration;
  final List<NavigationItemModel> items;
  final Widget? middleWidget;
  final Widget? topWidget;
  final Widget? bottomWidget;
  final String? name;
  final String? postion;
  final TextStyle? nameStyle;
  final TextStyle? positionStyle;

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return HoverOver(
        builder: (isHovered) {
          return AnimatedContainer(
            duration: widget.animationDuration,
            width: isHovered ? widget.expandedWidth : widget.collapsedWidth,
            decoration: BoxDecoration(
              color: widget.backgroundNavigationColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                if (widget.middleWidget != null) widget.middleWidget!,
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: widget.wholePadding,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: widget.items
                          .map((item) => _buildAnimatedItem(
                                item: item,
                                isHovered: isHovered,
                                isCompleted: isCompleted,
                              ))
                          .toList(),
                    ),
                  ),
                ),
                if (widget.middleWidget != null) widget.middleWidget!,
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: widget.bottomColor,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.srcImage ?? ''),
                        radius: 18,
                      ),
                      if (isHovered)
                        isCompleted
                            ? AnimatedOpacity(
                                duration: const Duration(milliseconds: 1000),
                                opacity: isHovered && isCompleted ? 1 : 0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      widget.bottomWidget == null
                                          ? Column(children: [
                                              Text(
                                                widget.name!,
                                                style: widget.nameStyle ??
                                                    const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xFF696EFF),
                                                    ),
                                              ),
                                              Text(
                                                widget.postion!,
                                                style: widget.positionStyle ??
                                                    const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ])
                                          : widget.bottomWidget!,
                                    ]),
                              )
                            : const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildAnimatedItem({
    required NavigationItemModel item,
    required bool isHovered,
    required bool isCompleted,
  }) {
    return HoverOver(
      builder: (hovering) {
        final iconColor = hovering
            ? (item.activeColor ?? Colors.white)
            : (item.inactiveColor ?? const Color(0xFF94A3B8));

        return AnimatedContainer(
          duration: Duration(
            milliseconds: isHovered ? (isCompleted ? 300 : 200) : 200,
          ),
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          height: item.height,
          width: isHovered ? (isCompleted ? 150 : 50) : 50,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: hovering ? 400 : 300),
                  width: isHovered ? (hovering ? 150 : 0) : 0,
                  height: item.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: item.gradient?? const LinearGradient(
                      colors: [Color(0xFF696EFF), Color(0xFFF8ACFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: item.padding!,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      HugeIcon(
                        icon: item.icon,
                        color: iconColor,
                        size: hovering ? 24 : 20,
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isHovered ? (isCompleted ? 1 : 0) : 0,
                        child: Text(
                          item.title,
                          style: item.titleStyle ?? TextStyle(
                            fontSize: isHovered ? (isCompleted ? 14 : 0) : 0,
                            fontWeight: FontWeight.w400,
                            color: isCompleted
                                ? (hovering
                                    ? Colors.white
                                    : const Color(0xFF94A3B8))
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
