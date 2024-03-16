# smart_calendar

智能、轻量级、易于扩展的 flutter 日历控件

![demo](assets/demo.gif)

## 截图

|                月视图                |               周视图               |
| :----------------------------------: | :--------------------------------: |
| ![month_view](assets/month_view.jpg) | ![week_view](assets/week_view.jpg) |

## 功能特点

- 🚀 支持月视图和周视图滚动时丝滑切换
- 🎉 易于扩展，支持自定义 UI

## 使用

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartCalendar(
        //日历背景颜色
        backgroundColor: Colors.white,
        //日历每行高度
        rowHeight: 44,
        //日历控制器
        calendarController: calendarController,
        //日历视图
        calendarFormat: CalendarFormat.WEEK,
        //选中日期改变事件
        onFocusedDayChanged: _onFocusedDayChanged,
        //日历视图改变事件
        onCalendarFormatChanged: _onCalendarFormatChange,
        //日历item点击事件
        onItemClick: _onCalendarItemClick,
        //日历item构建器
        itemBuilder: _buildCalendarItem,
        //其他控件
        slivers: _buildSlivers(),
      )
    );
  }
```
