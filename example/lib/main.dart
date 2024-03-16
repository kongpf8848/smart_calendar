import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:example/theme/AppTheme.dart';
import 'package:example/utils/calendar_utils.dart';
import 'package:smart_calendar/smart_calendar.dart';
import 'dart:io';

void main() {
  Intl.defaultLocale = "zh_CN";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
      ));
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale("zh", "CN"),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      theme: LightTheme,
      darkTheme: DarkTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late CalendarController calendarController;
  ValueNotifier<CalendarFormat> calendarFormatNotifier =
      ValueNotifier(CalendarFormat.WEEK);

  ValueNotifier<DateTime?> focusedDayNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);

    return Scaffold(
        appBar: _buildAppBar(localizations),
        body: Column(
          children: [
            _buildDaysOfWeek(localizations),
            Expanded(
              child: SmartCalendar(
                backgroundColor:
                    Theme.of(context).twColors.primaryBackgroundColor!,
                rowHeight: 44,
                calendarController: calendarController,
                calendarFormat: calendarFormatNotifier.value,
                onFocusedDayChanged: _onFocusedDayChanged,
                onCalendarFormatChanged: _onCalendarFormatChanged,
                onItemClick: _onCalendarItemClick,
                itemBuilder: _buildCalendarItem,
                slivers: _buildSlivers(),
              ),
            )
          ],
        ));
  }

  _onFocusedDayChanged(DateTime? focusedDay) {
    debugPrint('++++++++++++onFocusedDayChanged:$focusedDay');
    focusedDayNotifier.value = focusedDay;
  }

  _onCalendarFormatChanged(CalendarFormat format) {
    debugPrint('++++++++++++onCalendarFormatChange:$format');
    calendarFormatNotifier.value = format;
  }

  _onCalendarItemClick(CalendarItem bean) {
    debugPrint(
        "_onCalendarItemClick: ${bean.dateTime},${bean.isCurrentMonth},${bean.index},${calendarController.calendarFormat}");
  }

  Widget _buildDaysOfWeek(MaterialLocalizations localizations) {
    final List<Widget> result = <Widget>[];
    for (int i = 0; result.length < DateTime.daysPerWeek; i++) {
      final String weekday =
          localizations.narrowWeekdays[(i + 1) % DateTime.daysPerWeek];
      result.add(Expanded(
        child: Center(
            child: Text(weekday,
                style: TextStyle(
                  color: Theme.of(context).twColors.primaryTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ))),
      ));
    }
    return Container(
        color: Theme.of(context).twColors.primaryBackgroundColor,
        child: Row(children: result));
  }

  AppBar _buildAppBar(MaterialLocalizations localizations) {
    return AppBar(
        title: ValueListenableBuilder<DateTime?>(
            valueListenable: focusedDayNotifier,
            builder: (context, value, child) {
              var date = value ?? DateTime.now();
              return Text("${localizations.formatShortDate(date)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Theme.of(context).twColors.primaryTextColor,
                  ));
            }),
        actions: [
          ValueListenableBuilder<CalendarFormat>(
              valueListenable: calendarFormatNotifier,
              builder: (context, value, _) {
                return TextButton(
                  child: Text("${value.name}"),
                  onPressed: () {},
                );
              }),
          IconButton(
            tooltip: "设置",
            icon: const Icon(
              Icons.settings,
            ),
            onPressed: () {},
          ),
        ]);
  }

  Widget _buildCalendarItem(
      BuildContext context, int index, CalendarItem bean) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: getCalendarItemDecoration(
            context, bean, focusedDayNotifier.value),
        child: Text(
          "${bean.day}",
          style: getCalendarItemTextStyle(
              context,
              calendarController.calendarFormat,
              bean,
              focusedDayNotifier.value),
        ),
      ),
    );
  }

  List<Widget> _buildSlivers() {
    return [
      SliverPersistentHeader(
          pinned: true,
          delegate: StickyPersistentDelegate(
            child: Material(
                color: Theme.of(context).twColors.primaryBackgroundColor,
                elevation: 1,
                child: TabBar(
                  controller: TabController(length: 3, vsync: this),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.transparent,
                  tabs: [
                    FittedBox(
                        child: OutlinedButton(
                            child: Text("切换到周视图",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).twColors.primary)),
                            onPressed: () {
                              calendarController.shrink();
                            })),
                    FittedBox(
                      child: OutlinedButton(
                        child: Text("切换到月视图",
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).twColors.primary)),
                        onPressed: () {
                          calendarController.expand();
                        },
                      ),
                    ),
                    FittedBox(
                      child: OutlinedButton(
                        child: Text("切换周/月视图",
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).twColors.primary)),
                        onPressed: () {
                          calendarController.toggle();
                        },
                      ),
                    ),
                  ],
                )),
          )),
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => Container(
                    height: kToolbarHeight,
                    alignment: Alignment.center,
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: Text("$index"),
                  ),
              childCount: 20)),
    ];
  }
}
