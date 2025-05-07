import 'package:flutter/material.dart';

class CustomListViewController extends ChangeNotifier {
  int _firstVisibleIndex = 0;
  int _lastVisibleIndex = 0;
  int _itemCount = 0;
  Duration _duration = const Duration(milliseconds: 300);
  Curve _curve = Curves.easeInOut;

  final ScrollController scrollController = ScrollController();

  void setItemCount(
      {int count = 0,
      Duration duration = const Duration(milliseconds: 300),
      Curve curve = Curves.easeInOut}) {
    _itemCount = count;
    _duration = duration;
    _curve = curve;
    notifyListeners();
  }

  void updateVisibleRange(int first, int last) {
    if (_firstVisibleIndex != first || _lastVisibleIndex != last) {
      _firstVisibleIndex = first.clamp(0, _itemCount - 1);
      _lastVisibleIndex = last.clamp(0, _itemCount);

      // debugPrint(
      //     'First: $_firstVisibleIndex, Last: $_lastVisibleIndex, Item Count: $_itemCount');
      notifyListeners();
    }
  }

  bool get canGoNext => _lastVisibleIndex <= _itemCount - 1;
  bool get canGoPrevious => _firstVisibleIndex > 0;

  void next(double offset) {
    if (!canGoNext) return;
    scrollController.animateTo(
      scrollController.offset + offset, // adjust based on item size
      duration: _duration,
      curve: _curve,
    );
  }

  void previous(double offset) {
    if (!canGoPrevious) return;
    scrollController.animateTo(
      scrollController.offset - offset,
      duration: _duration,
      curve: _curve,
    );
  }

  void calculateVisibleItems({
    required double scrollOffset,
    required double viewportExtent,
    required double itemExtent,
    double itemSpacing = 0,
  }) {
    final totalItemWidth = itemExtent + itemSpacing;
    final first = (scrollOffset / totalItemWidth).floor();
    final last = ((scrollOffset + viewportExtent) / totalItemWidth).ceil();

    updateVisibleRange(
        first.clamp(0, _itemCount - 1), last.clamp(0, _itemCount));
  }

  int get visibleItemCount => (_lastVisibleIndex).clamp(0, _itemCount);
}
