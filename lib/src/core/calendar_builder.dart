//日历gridItem比例

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar_page.dart';
import 'calendar_item.dart';

const int HorizontalItemCount = 7;
const double GridSpacing = 0;
const double GridVerticalPadding = 0;
const double GridHorizontalPadding = 0;

//起始年份
const StartYear = 1900;
//结束年份
const EndYear = 2100;
const WeekPageDataCount = 9999;
const WeekPageInitialIndex = 5000;

class CalendarBuilder {
  CalendarBuilder._();

  static ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);

  //1900-2100;日历页数
  static final int count = (EndYear - StartYear) * 12;

  static CalendarBuilder? _instance;

  factory CalendarBuilder() => _getInstance();

  static CalendarBuilder get instance => _getInstance();

  static OnClick<CalendarPagerItemBean, CalendarItem> onClick =
      (pageBean, gridBean) {
    int selectLine = gridBean.index ~/ HorizontalItemCount;
    pageBean.selectedLine = selectLine;
    if (pageBean.beans.length > 7) {
      _cache[pageBean.index] = pageBean;
    }
  };

  //缓存的日历数据
  static Map<int, CalendarPagerItemBean> _cache = {};

  static _getInstance() {
    if (_instance == null) {
      _instance = new CalendarBuilder._();
    }
    return _instance;
  }

  static CalendarPagerItemBean build(int index) {
    int year = StartYear + index ~/ 12;
    int month = index % 12 + 1;
    DateTime dateTime = DateTime(year, month);
    if (!_cache.containsKey(index)) {
      _cache[index] = _buildData(index, dateTime);
    }

    CalendarPagerItemBean? bean = _cache[index];
    return bean!;
  }

  static CalendarPagerItemBean buildWeekData(
      DateTime startDate, DateTime currentDate) {
    debugPrint('++++++++SmartCalendar,buildWeekData00:$startDate:startDate,currentDate:$currentDate');
    List<CalendarItem> beans = [];
    CalendarItem? _bean;
    int index = dateTimeToIndex(startDate);
    for (int i = 0; i < HorizontalItemCount; i++) {
      CalendarItem b = CalendarItem.build(startDate,
          day: startDate.day,
          isCurrentMonth: startDate.month == currentDate.month);
      if (b.isToday) {
        _bean = b;
      }
      beans.add(b);
      startDate = startDate.add(Duration(days: 1));
    }

    List<CalendarItem> week =
        beans.where((element) => !element.isCurrentMonth).toList();
    if (week.length == HorizontalItemCount) {
      beans.forEach((element) {
        element.isCurrentMonth = true;
      });
    }

    print('++++++++buildWeekData11:index:$index,$beans:beans');
    print('++++++++buildWeekData22:$week:week');


    int todayIndex = -1;
    if (_bean != null) {
      todayIndex = beans.indexOf(_bean);
    }

    return CalendarPagerItemBean(
        index: index,
        beans: beans,
        currentDate: startDate,
        todayIndex: todayIndex,
        selectedLine: todayIndex != -1 ? todayIndex ~/ HorizontalItemCount : 0,
        onClick: onClick);
  }

  static int dateTimeToIndex(DateTime dateTime) {
    int year = dateTime.year - StartYear;
    int month = dateTime.month;
    return year * 12 + month - 1;
  }

  static CalendarPagerItemBean _buildData(
    int index,
    DateTime dateTime,
  ) {
    List<CalendarItem> beans = [];
    final days = DateUtils.getDaysInMonth(dateTime.year, dateTime.month);
    DateTime startWeekDay = DateTime(dateTime.year, dateTime.month, 1);
    DateTime endWeekDay = DateTime(dateTime.year, dateTime.month, days);
    debugPrint(
        '++++++++++++++calendarbuilddata,index:$index,dateTime:$dateTime,days:${days},startWeekDay:${startWeekDay},endWeekDay:${endWeekDay}');
    CalendarItem? _bean;
    for (int i = 1; i <= days; i++) {
      CalendarItem b = CalendarItem.build(
        dateTime,
        day: i,
      );
      if (b.isToday) {
        _bean = b;
      }
      beans.add(b);
    }

    while (startWeekDay.weekday != 1) {
      startWeekDay = startWeekDay.subtract(Duration(days: 1));
      beans.insert(0, CalendarItem.build(startWeekDay, isCurrentMonth: false));
    }
    while (endWeekDay.weekday != 7) {
      endWeekDay = endWeekDay.add(Duration(days: 1));
      beans.add(CalendarItem.build(endWeekDay, isCurrentMonth: false));
    }

    final len = beans.length;
    for (int i = 0; i < len; i++) {
      beans[i].index = i;
    }

    int todayIndex = -1;
    if (_bean != null) {
      todayIndex = beans.indexOf(_bean);
    }

    return CalendarPagerItemBean(
        index: index,
        beans: beans,
        currentDate: dateTime,
        todayIndex: todayIndex,
        selectedLine: todayIndex != -1 ? todayIndex ~/ HorizontalItemCount : 0,
        onClick: onClick);
  }
}
