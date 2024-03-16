# smart_calendar

A Smart Calendar for Flutter

# Use
```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartCalendar(
        backgroundColor: Colors.white,
        rowHeight: 44,
        calendarController: calendarController,
        calendarFormat: CalendarFormat.WEEK,
        onCalendarFormatChanged: _onCalendarFormatChange,
        onItemClick: _onCalendarItemClick,
        itemBuilder: _buildCalendarItem,
        slivers: _buildSlivers(),
      )
    );
  }
```
