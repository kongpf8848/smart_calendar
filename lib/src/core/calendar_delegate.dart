import 'package:flutter/animation.dart';

import '../../smart_calendar.dart';

abstract class CalendarDelegate {
  void expand();

  void shrink();

  void changeToDate(DateTime dateTime);

  void previousPage(Duration duration, Curve curve);

  void nextPage(Duration duration, Curve curve);

  CalendarFormat get calendarFormat;
}
