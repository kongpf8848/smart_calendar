import 'package:flutter/material.dart';

class StickyPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final Color color;

  StickyPersistentDelegate(
      {required this.child,
      this.height = kToolbarHeight,
      this.color = Colors.white});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: this.child,
      height: height,
      color: this.color,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(StickyPersistentDelegate oldDelegate) {
    return oldDelegate.child != child ||
        oldDelegate.height != height ||
        oldDelegate.color != color;
  }
}
