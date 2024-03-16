import 'package:flutter/material.dart';

typedef WidgetBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

class PersistentHeaderDelegateBuilder extends SliverPersistentHeaderDelegate {
  final double max;
  final double min;
  final WidgetBuilder builder;

  PersistentHeaderDelegateBuilder(
      {this.max = 200, this.min = 50, required this.builder});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(covariant PersistentHeaderDelegateBuilder oldDelegate) {
    return oldDelegate.max != max ||
        oldDelegate.min != min ||
        oldDelegate.builder != builder;
  }

  @override
  double get maxExtent => max;

  @override
  double get minExtent => min;
}
