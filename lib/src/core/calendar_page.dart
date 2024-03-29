import 'package:flutter/material.dart';

import 'calendar_builder.dart';
import 'calendar_item.dart';

typedef CalendarItemBuilder = Widget Function(
    BuildContext context, int index, CalendarItem bean);

class CalendarPagerItem extends StatefulWidget {
  final CalendarPagerItemBean bean;
  final double rowHeight;
  final ScrollController? controller;
  final CalendarItemBuilder itemBuilder;
  final Color backgroundColor;
  final ValueChanged<CalendarItem>? onItemClick;

  const CalendarPagerItem(
      {Key? key,
      required this.itemBuilder,
      this.onItemClick,
      required this.bean,
      required this.rowHeight,
      this.backgroundColor = Colors.white,
      this.controller})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CalendarPagerItemState(itemBuilder);
  }
}

class _CalendarPagerItemState extends State<CalendarPagerItem> {
  List<CalendarItem> beans = [];
  late CalendarPagerItemBean bean;
  bool init = true;
  final CalendarItemBuilder itemBuilder;

  _CalendarPagerItemState(this.itemBuilder) : assert(itemBuilder != null);

  @override
  void initState() {
    bean = widget.bean;
    beans.addAll(bean.beans);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: GridVerticalPadding,
          horizontal: GridHorizontalPadding,
        ),
        color: widget.backgroundColor,
        child: GridView.builder(
          controller: widget.controller,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: widget.rowHeight,
              crossAxisCount: HorizontalItemCount,
              crossAxisSpacing: GridSpacing,
              mainAxisSpacing: GridSpacing),
          itemBuilder: (c, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: itemBuilder(c, index, beans[index]),
              onTap: () {
                CalendarItem b = beans[index];
                CalendarBuilder.selectedDate.value = b.dateTime;
                setState(() {});
                if (widget.onItemClick != null) {
                  widget.onItemClick!(b);
                }
                if (bean.onClick != null) {
                  bean.onClick!(bean, b);
                }
              },
            );
          },
          itemCount: beans.length,
        ));
  }
}

typedef OnClick<T, E> = void Function(T t, E v);

class CalendarPagerItemBean {
  final OnClick<CalendarPagerItemBean, CalendarItem>? onClick;

  // 默认-1 表示不存在
  final int todayIndex;
  int selectedLine = 0;
  final int index;
  final List<CalendarItem> beans;
  final DateTime? currentDate;

  CalendarPagerItemBean({
    this.beans = const [],
    this.currentDate,
    this.onClick,
    this.todayIndex = -1,
    this.selectedLine = 0,
    required this.index,
  });
}
