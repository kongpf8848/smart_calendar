import 'package:example/theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:smart_calendar/smart_calendar.dart';


final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

TextStyle defaultCalendarTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).twColors.primaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}

TextStyle todayTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).twColors.primary,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}

TextStyle todaySelectedTextStyle(BuildContext context) {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}

TextStyle outsideTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).twColors.thirdTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
}

BoxDecoration blueBoxDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).twColors.primary,
    borderRadius: BorderRadius.circular(4),
  );
}

BoxDecoration grayBoxDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).twColors.fillOffBackgroundColor,
    borderRadius: BorderRadius.circular(4),
  );
}

BoxDecoration? getCalendarItemDecoration(BuildContext context,
    CalendarItem calendarItem, DateTime? focusedDay){
  if(calendarItem.dateTime == CalendarBuilder.selectedDate.value) {
    if (DateUtils.isSameDay(calendarItem.dateTime,DateTime.now())) {
      return blueBoxDecoration(context);
    }else{
      return grayBoxDecoration(context);
    }
  }
  return null;
}

TextStyle getCalendarItemTextStyle(BuildContext context, CalendarFormat calendarFormat,
    CalendarItem calendarItem, DateTime? focusedDay) {

  if(DateUtils.isSameDay(calendarItem.dateTime, DateTime.now())){
     if(DateUtils.isSameDay(calendarItem.dateTime,focusedDay)){
       return todaySelectedTextStyle(context);
     }else{
       return todayTextStyle(context);
     }
  }

  if (calendarFormat.isWeekView()) {
    if (calendarItem.dateTime.isAfter(DateTime.now())) {
      return defaultCalendarTextStyle(context);
    } else {
      return outsideTextStyle(context);
    }
  } else if (calendarFormat.isMonthView()) {
    if (calendarItem.isCurrentMonth) {
      return defaultCalendarTextStyle(context);
    } else {
      return outsideTextStyle(context);
    }
  }
  return defaultCalendarTextStyle(context);
}
