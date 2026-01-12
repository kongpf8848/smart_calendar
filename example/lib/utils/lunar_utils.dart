import 'dart:ffi';

import 'package:lunar/calendar/Lunar.dart';
import 'package:lunar/calendar/Solar.dart';

String getLunarDayInfo(DateTime datetime) {
  Lunar lunar = Lunar.fromSolar(Solar.fromDate(datetime));
  var jieQi = lunar.getJieQi();
  if (!jieQi.isEmpty) {
    return jieQi;
  }
  return lunar.getDayInChinese();
}

bool isJieQi(DateTime datetime) {
  Lunar lunar = Lunar.fromSolar(Solar.fromDate(datetime));
  var jieQi = lunar.getJieQi();
  return jieQi.isNotEmpty;
}
