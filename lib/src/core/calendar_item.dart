import 'calendar_builder.dart';

class CalendarItem {
  //所在日期
  final DateTime dateTime;

  //是否是当前月份
  bool isCurrentMonth;

  //是否是今天
  final bool isToday;

  //所在集合中的角标
  int index = -1;

  CalendarItem({
    required this.dateTime,
    this.isCurrentMonth = true,
    this.isToday = false,
  });

  int get year => dateTime.year;

  int get month => dateTime.month;

  int get day => dateTime.day;

  static CalendarItem build(DateTime dateTime,
      {int? day, bool isCurrentMonth = true}) {
    bool isToday = false;
    if (day != null) {
      final now = DateTime.now();
      dateTime = DateTime(dateTime.year, dateTime.month, day);
      isToday = now.year == dateTime.year &&
          now.month == dateTime.month &&
          now.day == dateTime.day;
    }
    if (isToday && CalendarBuilder.selectedDate.value == null) {
      CalendarBuilder.selectedDate.value = dateTime;
    }
    final bean = CalendarItem(
      dateTime: dateTime,
      isToday: isToday,
      isCurrentMonth: isCurrentMonth,
    );
    return bean;
  }
}
