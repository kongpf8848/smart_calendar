enum CalendarFormat { WEEK, MONTH }

extension CalendarFormatExtension on CalendarFormat {
  //当前处于周视图
  isWeekView() => this == CalendarFormat.WEEK;

  //当前处于月视图
  isMonthView() => this == CalendarFormat.MONTH;
}