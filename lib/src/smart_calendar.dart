import 'package:flutter/material.dart';

import '../smart_calendar.dart';

GlobalKey<_SmartCalendarState> calendarKey = GlobalKey();

typedef OnFocusedDayChanged = void Function(DateTime focusedDay);

class SmartCalendar extends StatefulWidget {
  final String TAG = "SmartCalendar";
  final bool scrollable;
  final double rowHeight;
  final CalendarItemBuilder itemBuilder;
  final Color backgroundColor;
  final ValueChanged<CalendarItem>? onItemClick;
  final List<Widget> slivers;
  final CalendarController calendarController;
  final SliverPersistentHeader? sliverPersistentHeader;
  final double? sliverHeaderHeight;
  final CalendarFormat? calendarFormat;

  final OnFocusedDayChanged? onFocusedDayChanged;
  final ValueChanged<CalendarFormat>? onCalendarFormatChanged;

  SmartCalendar({
    Key? key,
    this.backgroundColor = Colors.white,
    this.rowHeight = 44,
    this.scrollable = true,
    this.calendarFormat,
    required this.itemBuilder,
    required this.calendarController,
    this.onItemClick,
    this.onFocusedDayChanged,
    this.onCalendarFormatChanged,
    this.slivers = const <Widget>[],
    this.sliverPersistentHeader,
    this.sliverHeaderHeight,
  })  : assert((sliverPersistentHeader != null && sliverHeaderHeight != null) ||
            (sliverPersistentHeader == null && sliverHeaderHeight == null)),
        super(key: key);

  @override
  State<SmartCalendar> createState() => _SmartCalendarState();
}

class _SmartCalendarState extends State<SmartCalendar>
    with TickerProviderStateMixin, CalendarDelegate {
  late double toolbarHeight;
  double? screenSize;
  ScrollController mainController = ScrollController();
  ScrollController gridController = ScrollController();
  late PageController monthPageController;
  late PageController weekPageController;
  late CalendarController calendarController;

  int pageIndex = 0;

  //滑动时锁定的pageIndex
  int lockingPageIndex = 0;

  late double expandedHeight;

  //根据滑动时锁定的lockingPageIndex获取的expandedHeight
  late double lockingExpandedHeight;

  //防止横向滚动时 GridView缩小动画导致页面跳动
  bool isHorizontalScroll = false;

  //日历展示模式 默认为月视图
  CalendarFormat _calendarFormat = CalendarFormat.MONTH;

  double flexibleSpaceHeight = 0.0;

  //选中的行数
  int selectLine = 0;

  int get month => pageIndex % 12 + 1;

  int get year => StartYear + pageIndex ~/ 12;

  //日历总行数
  int get lines => selectItemData.beans.length ~/ HorizontalItemCount;

  //收起时的时间
  late DateTime shrinkDateTime;

  ValueChanged<CalendarItem>? _onItemClick;

  double sliverHeaderHeight = 0;

  CalendarPagerItemBean get selectItemData {
    return _buildItemData(pageIndex);
  }

  CalendarPagerItemBean _buildItemData(int index) {
    return CalendarBuilder.build(index);
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    pageIndex = CalendarBuilder.dateTimeToIndex(now);

    _calendarFormat = widget.calendarFormat ?? CalendarFormat.MONTH;
    while (now.weekday != 1) {
      now = now.subtract(Duration(days: 1));
    }
    shrinkDateTime = DateTime(now.year, now.month, now.day);

    lockingPageIndex = pageIndex;

    monthPageController = PageController(initialPage: pageIndex);
    weekPageController = PageController(initialPage: WeekPageInitialIndex);

    _onItemClick = (v) {
      if (calendarFormat.isMonthView()) {
        if (!v.isCurrentMonth) {
          changeToDate(v.dateTime);
        }
      } else {
        setState(() {});
      }
      widget.onItemClick?.call(v);
    };

    calendarController = widget.calendarController;
    calendarController.attach(this);

    if (widget.sliverPersistentHeader != null) {
      sliverHeaderHeight = widget.sliverHeaderHeight!;
    } else {
      sliverHeaderHeight = 0;
    }
    debugPrint("+++++++++++SmartCalendar,shrinkDateTime:$shrinkDateTime");

    super.initState();
    CalendarBuilder.selectedDate.addListener(() {
      widget.onFocusedDayChanged?.call(CalendarBuilder.selectedDate.value!);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      debugPrint("SmartCalendar initState: Frame has been rendered");
      Future.delayed(Duration(milliseconds: 300), () {
        monthPageController.addListener(() => _onPageScrolling());
        mainController.addListener(() => _onMainScrolling());
      });
    });
  }

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (screenSize == null) {
      screenSize = MediaQuery.of(context).size.width;
      toolbarHeight = widget.rowHeight;
      expandedHeight = _getExpandHeight(lines);
      lockingExpandedHeight = expandedHeight;

      debugPrint(
          "+++++++++++SmartCalendar,toolbarHeight:$toolbarHeight,line:${lines},expandedHeight:$expandedHeight");

      if (_calendarFormat.isWeekView()) {
        Future.delayed(Duration.zero, () {
          mainController
              .jumpTo(_getExpandHeight(lines - 1) + sliverHeaderHeight);
        });
      }
    }
    return NotificationListener(
      onNotification: (Notification notification) {
        return _checkScroll(notification);
      },
      child: CustomScrollView(
        physics: widget.scrollable
            ? ClampingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        controller: mainController,
        slivers: [
          if (widget.sliverPersistentHeader != null)
            widget.sliverPersistentHeader!,
          _buildCalendar(),
          ...widget.slivers
        ],
      ),
    );
  }

  Widget _buildFlexibleSpace() {
    return LayoutBuilder(
      builder: (context, constraints) {
        flexibleSpaceHeight = constraints.biggest.height;
        if (flexibleSpaceHeight <=
                toolbarHeight * lines + GridVerticalPadding * 2 &&
            gridController.hasClients &&
            !isHorizontalScroll) {
          gridController.jumpTo((toolbarHeight * lines +
                      GridVerticalPadding * 2 -
                      flexibleSpaceHeight) *
                  selectLine /
                  (lines - 1) +
              selectLine * GridSpacing);
        }

        return Stack(
          children: [
            PageView.builder(
              controller: monthPageController,
              onPageChanged: (index) => _onPageChange(index),
              itemBuilder: (c, i) {
                var bean = _buildItemData(i);
                selectLine = bean.selectedLine;
                return CalendarPagerItem(
                  onItemClick: _onItemClick,
                  backgroundColor: widget.backgroundColor,
                  itemBuilder: widget.itemBuilder,
                  rowHeight: toolbarHeight,
                  bean: bean,
                  controller: gridController,
                );
              },
              itemCount: CalendarBuilder.count,
            ),
            if (_calendarFormat.isWeekView())
              PageView.builder(
                controller: weekPageController,
                onPageChanged: (i) => _onWeekPageChange(i),
                itemBuilder: (c, i) {
                  var bean = CalendarBuilder.buildWeekData(
                      shrinkDateTime.add(Duration(
                          days: HorizontalItemCount *
                              (i - WeekPageInitialIndex))),
                      selectItemData.currentDate!);
                  return CalendarPagerItem(
                    onItemClick: _onItemClick,
                    backgroundColor: widget.backgroundColor,
                    itemBuilder: widget.itemBuilder,
                    rowHeight: widget.rowHeight,
                    bean: bean,
                  );
                },
                itemCount: WeekPageDataCount,
              ),
          ],
        );
      },
    );
  }

  _onWeekPageChange(int i) {
    debugPrint(
        '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，index:$i');
    final bean = CalendarBuilder.buildWeekData(
        shrinkDateTime.add(
            Duration(days: HorizontalItemCount * (i - WeekPageInitialIndex))),
        selectItemData.currentDate!);
    DateTime prevFocusedDay = CalendarBuilder.selectedDate.value!;
    debugPrint(
        '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，prevFocusedDay:$prevFocusedDay');
    if (bean.currentDate!.isAfter(CalendarBuilder.selectedDate.value!)) {
      CalendarBuilder.selectedDate.value = DateTime(
          prevFocusedDay.year, prevFocusedDay.month, prevFocusedDay.day + 7);
    } else {
      CalendarBuilder.selectedDate.value = DateTime(
          prevFocusedDay.year, prevFocusedDay.month, prevFocusedDay.day - 7);
    }
    debugPrint(
        '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，afterFocusedDay:${CalendarBuilder.selectedDate.value}');

    CalendarItem? item;
    try {
      item = bean.beans.firstWhere((element) => DateUtils.isSameDay(
          element.dateTime, CalendarBuilder.selectedDate.value));
    } catch (e) {
      debugPrint(
          '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，error00:$e');
    }
    debugPrint(
        '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，item:$item');

    if (item != null) {
      pageIndex = CalendarBuilder.dateTimeToIndex(item.dateTime);
    } else {
      pageIndex = bean.index;
    }
    debugPrint(
        '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，pageIndex:$pageIndex');

    monthPageController.jumpToPage(pageIndex);

    try {
      final dateTime = CalendarBuilder.selectedDate.value;
      CalendarItem list = selectItemData.beans
          .firstWhere((element) => element.dateTime == dateTime);
      selectItemData.selectedLine = list.index ~/ HorizontalItemCount;
      debugPrint(
          '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，dateTime:$dateTime,selectedLine:${selectItemData.selectedLine}');
    } catch (e) {
      debugPrint(
          '+++++++++++++++++++++++SmartCalendar,_onWeekPageChange，error11:$e');
    }
    setState(() {});
  }

  _onPageChange(int index) {
    pageIndex = index;
    if (calendarFormat.isMonthView() &&
        !DateUtils.isSameMonth(
            selectItemData.currentDate, CalendarBuilder.selectedDate.value)) {
      debugPrint(
          '+++++++++++++++SmartCalendar,_onPageChange00,index:$pageIndex,$year,$month,${selectItemData.currentDate}');
      CalendarBuilder.selectedDate.value = selectItemData.currentDate;
      expandedHeight = _getExpandHeight(lines);
      selectItemData.selectedLine = 0;
      debugPrint(
          '+++++++++++++++SmartCalendar,_onPageChange11,selectedDate:${CalendarBuilder.selectedDate.value}');
    }
    setState(() {});
  }

  Widget _buildCalendar() {
    return SliverAppBar(
      backgroundColor: widget.backgroundColor,
      pinned: true,
      toolbarHeight: toolbarHeight + GridVerticalPadding * 2,
      expandedHeight: expandedHeight,
      flexibleSpace: _buildFlexibleSpace(),
    );
  }

  _checkScroll(Notification notification) {
    if (notification is OverscrollIndicatorNotification) {
      notification.disallowIndicator();
      return true;
    } else if (notification is ScrollEndNotification) {
      if (mainController.position.maxScrollExtent ==
          notification.metrics.maxScrollExtent) {
        Future.delayed(Duration.zero, () => _onMainScrollEnd());
      } else if (notification.metrics.axis == Axis.horizontal) {
        isHorizontalScroll = false;
        lockingPageIndex = pageIndex;
        lockingExpandedHeight = _getExpandHeight(lines);
      }
    }
    return false;
  }

  double _getExpandHeight(int lines) {
    return lines * toolbarHeight +
        GridVerticalPadding * 2 +
        (lines - 1) * GridSpacing;
  }

  _onMainScrollEnd() {
    if (flexibleSpaceHeight == toolbarHeight + GridVerticalPadding * 2) {
      int index = selectItemData.selectedLine * HorizontalItemCount;
      shrinkDateTime = selectItemData.beans[index].dateTime;
      weekPageController = PageController(initialPage: WeekPageInitialIndex);
      debugPrint(
          '+++++++++++++SmartCalendar,onCalendarFormatChanged00,,${selectItemData.selectedLine},shrinkDateTime:$shrinkDateTime');
      _onCalendarFormatChanged(CalendarFormat.WEEK);
      setState(() {});
    }
    // else {
    //   debugPrint('+++++++++++++SmartCalendar,onCalendarFormatChanged11(CalendarFormat.MONTH');
    //   _onCalendarFormatChanged(CalendarFormat.MONTH);
    // }
    if (flexibleSpaceHeight > toolbarHeight + GridVerticalPadding * 2 &&
        flexibleSpaceHeight < toolbarHeight * lines / 2 + GridVerticalPadding) {
      shrink();
    } else if (flexibleSpaceHeight > toolbarHeight * lines / 2 &&
        flexibleSpaceHeight < toolbarHeight * lines) {
      expand();
    }
  }

  _onMainScrolling() {
    if (_calendarFormat.isWeekView() &&
        mainController.offset >
            _getExpandHeight(lines - 1) / 2 + sliverHeaderHeight) {
      expandedHeight = _getExpandHeight(lines);
      debugPrint(
          '+++++++++++++SmartCalendar,onCalendarFormatChanged22(CalendarFormat.MONTH');
      _onCalendarFormatChanged(CalendarFormat.MONTH);
      setState(() {});
    }
  }

  _onPageScrolling() {
    if (_calendarFormat.isWeekView()) {
      return;
    }

    isHorizontalScroll = true;
    final move = monthPageController.offset;
    final pageOffset = lockingPageIndex * (screenSize ?? 0);
    int offset;
    //左滑
    if (move > pageOffset) {
      offset = lockingPageIndex + 1;
    } else
    //右滑
    if (move < pageOffset) {
      offset = lockingPageIndex - 1;
    } else {
      offset = pageIndex;
    }

    int newLines = _buildItemData(offset).beans.length ~/ HorizontalItemCount;

    double newHeight = _getExpandHeight(newLines);

    if (newHeight != expandedHeight) {
      final addPart = (newHeight - lockingExpandedHeight) *
          ((move - pageOffset).abs()) /
          (screenSize ?? 1);
      expandedHeight = lockingExpandedHeight + addPart;
      setState(() {});
    }
  }

  _onCalendarFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      this._calendarFormat = format;
      widget.onCalendarFormatChanged?.call(format);
    }
  }

  @override
  void changeToDate(DateTime dateTime) {
    CalendarBuilder.selectedDate.value =
        DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (_calendarFormat.isWeekView()) {
      int num = 0;
      if (dateTime.isBefore(shrinkDateTime)) {
        //往前减一周
        num = -1;
      }
      Duration du = dateTime.difference(shrinkDateTime);
      num += du.inDays ~/ 7;
      weekPageController.jumpToPage(WeekPageInitialIndex + num);
    }

    pageIndex = CalendarBuilder.dateTimeToIndex(dateTime);
    monthPageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    expandedHeight = _getExpandHeight(lines);
    try {
      final CalendarItem item = selectItemData.beans.firstWhere(
          (element) => element.dateTime == CalendarBuilder.selectedDate.value);
      selectItemData.selectedLine = selectItemData.beans.indexOf(item) ~/ 7;
    } catch (e) {}
    setState(() {});
  }

  @override
  void shrink() {
    double height = _getExpandHeight(lines - 1) + sliverHeaderHeight;
    if (mainController.hasClients && height != mainController.offset) {
      mainController.animateTo(height,
          duration: Duration(milliseconds: 300), curve: Curves.easeOutQuad);
    }
  }

  @override
  void expand() {
    debugPrint(
        '+++++++++++SmartCalendar,expand,offset:${mainController.offset}');
    if (mainController.hasClients && mainController.offset != 0) {
      mainController.animateTo(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOutQuad);
    }
  }

  @override
  void nextPage(Duration duration, Curve curve) {}

  @override
  void previousPage(Duration duration, Curve curve) {}

  @override
  CalendarFormat get calendarFormat => _calendarFormat;
}
