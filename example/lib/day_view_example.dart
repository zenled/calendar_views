import 'package:calendar_views/day_view.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'utils/all.dart';

@immutable
class Event {
  Event({
    required this.startMinuteOfDay,
    required this.duration,
    required this.title,
  });

  final int startMinuteOfDay;
  final int duration;

  final String title;
}

List<Event> eventsOfDay0 = <Event>[
  Event(startMinuteOfDay: 0, duration: 60, title: "Midnight Party"),
  Event(startMinuteOfDay: 6 * 60, duration: 2 * 60, title: "Morning Routine"),
  Event(startMinuteOfDay: 6 * 60, duration: 60, title: "Eat Breakfast"),
  Event(startMinuteOfDay: 7 * 60, duration: 60, title: "Get Dressed"),
  Event(startMinuteOfDay: 18 * 60, duration: 60, title: "Take Dog For A Walk"),
];

List<Event> eventsOfDay1 = <Event>[
  Event(startMinuteOfDay: 1 * 60, duration: 90, title: "Sleep Walking"),
  Event(startMinuteOfDay: 7 * 60, duration: 60, title: "Drive To Work"),
  Event(startMinuteOfDay: 8 * 60, duration: 20, title: "A"),
  Event(startMinuteOfDay: 8 * 60, duration: 30, title: "B"),
  Event(startMinuteOfDay: 8 * 60, duration: 60, title: "C"),
  Event(startMinuteOfDay: 8 * 60 + 10, duration: 20, title: "D"),
  Event(startMinuteOfDay: 8 * 60 + 30, duration: 30, title: "E"),
  Event(startMinuteOfDay: 23 * 60, duration: 60, title: "Midnight Snack"),
];

class DayViewExample extends StatefulWidget {
  @override
  State createState() => _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  DateTime? _day0;
  DateTime? _day1;

  @override
  void initState() {
    super.initState();

    _day0 = DateTime.now();
    _day1 = _day0!.toUtc().add(Duration(days: 1)).toLocal();
  }

  String _minuteOfDayToHourMinuteString(int minuteOfDay) {
    return "${(minuteOfDay ~/ 60).toString().padLeft(2, "0")}"
        ":"
        "${(minuteOfDay % 60).toString().padLeft(2, "0")}";
  }

  List<StartDurationItem> _getEventsOfDay(DateTime day) {
    List<Event> events;
    if (day.year == _day0!.year &&
        day.month == _day0!.month &&
        day.day == _day0!.day) {
      events = eventsOfDay0;
    } else {
      events = eventsOfDay1;
    }

    return events
        .map(
          (event) => StartDurationItem(
            startMinuteOfDay: event.startMinuteOfDay,
            duration: event.duration,
            builder: (context, itemPosition, itemSize) => _eventBuilder(
              context,
              itemPosition,
              itemSize,
              event,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DayView Example"),
      ),
      body: DayViewEssentials(
        properties: DayViewProperties(
          days: <DateTime?>[
            _day0,
            _day1,
          ] as List<DateTime>,
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              child: DayViewDaysHeader(
                headerItemBuilder: _headerItemBuilder,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: DayViewSchedule(
                  heightPerMinute: 1.0,
                  components: <ScheduleComponent>[
                    TimeIndicationComponent.intervalGenerated(
                      generatedTimeIndicatorBuilder:
                          _generatedTimeIndicatorBuilder,
                    ),
                    SupportLineComponent.intervalGenerated(
                      generatedSupportLineBuilder: _generatedSupportLineBuilder,
                    ),
                    DaySeparationComponent(
                      generatedDaySeparatorBuilder:
                          _generatedDaySeparatorBuilder,
                    ),
                    EventViewComponent(
                      getEventsOfDay: _getEventsOfDay,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerItemBuilder(BuildContext context, DateTime day) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: <Widget>[
          Text(
            "${weekdayToAbbreviatedString(day.weekday)}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("${day.day}"),
        ],
      ),
    );
  }

  Positioned _generatedTimeIndicatorBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    int minuteOfDay,
  ) {
    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: Container(
        child: Center(
          child: Text(_minuteOfDayToHourMinuteString(minuteOfDay)),
        ),
      ),
    );
  }

  Positioned _generatedSupportLineBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    double itemWidth,
    int minuteOfDay,
  ) {
    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemWidth,
      child: Container(
        height: 0.7,
        color: Colors.grey[700],
      ),
    );
  }

  Positioned _generatedDaySeparatorBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    int daySeparatorNumber,
  ) {
    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: Center(
        child: Container(
          width: 0.7,
          color: Colors.grey,
        ),
      ),
    );
  }

  Positioned _eventBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    Event event,
  ) {
    return Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: Container(
        margin: EdgeInsets.only(left: 1.0, right: 1.0, bottom: 1.0),
        padding: EdgeInsets.all(3.0),
        color: Colors.green[200],
        child: Text("${event.title}"),
      ),
    );
  }
}
