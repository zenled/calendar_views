import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:calendar_views/day_view.dart';
//import 'package:calendarro/calendarro.dart';
//import 'package:calendarro/date_utils.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:intl/intl.dart';
import 'utils/all.dart';
import 'dart:math';


@immutable
class Event {
  Event({
    this.startMinuteOfDay,
    this.duration,
    this.boCompleted = false,
    @required this.title,
  });

  final int startMinuteOfDay;
  final int duration;
  bool boCompleted;
  final String title;
}

List<Event> eventsOfDay0 = <Event>[
  new Event(startMinuteOfDay: 0, duration: 60, title: "Midnight Party", boCompleted: true),
  new Event(
      startMinuteOfDay: 6 * 60, duration: 2 * 60, title: "Morning Routine"),
  new Event(startMinuteOfDay: 6 * 60, duration: 60, title: "Eat Breakfast"),
  new Event(startMinuteOfDay: 7 * 60, duration: 60, title: "Get Dressed"),
  new Event(
      startMinuteOfDay: 18 * 60, duration: 60, title: "Take Dog For A Walk"),
];

List<Event> eventsOfDay1 = <Event>[
  new Event(startMinuteOfDay: 1 * 60, duration: 90, title: "Sleep Walking"),
  new Event(startMinuteOfDay: 7 * 60, duration: 60, title: "Drive To Work"),
  new Event(startMinuteOfDay: 8 * 60, duration: 20, title: "A"),
  new Event(startMinuteOfDay: 8 * 60, duration: 30, title: "B"),
  new Event(startMinuteOfDay: 8 * 60, duration: 60, title: "C"),
  new Event(startMinuteOfDay: 8 * 60 + 10, duration: 20, title: "D"),
  new Event(startMinuteOfDay: 8 * 60 + 30, duration: 30, title: "E"),
  new Event(startMinuteOfDay: 23 * 60, duration: 60, title: "Midnight Snack"),
];

List<Event> anytimeEventsOfDay0 = <Event>[
  new Event(title: "Midnight Party"),
  new Event(title: "Morning Routine"),
  new Event(title: "Eat Breakfast"),
  new Event(title: "Get Dressed"),
  new Event(title: "Take Dog For A Walk hjhjhjhj"),
];

List<Event> anytimeEventsOfDay1 = <Event>[
  new Event(title: "Sleep Walking", boCompleted: true),
  new Event(title: "Drive To Work"),
];

class DayViewExample extends StatefulWidget {
  @override
  State createState() => new _DayViewExampleState();
}

class _DayViewExampleState extends State<DayViewExample> {
  DateTime _day0;
  DateTime _day1;
  DateTime startTime;
  List<DateTime> dayList;
  List<String> userIds;
  ScrollController _mycontroller1 =
      new ScrollController(); // make seperate controllers
  ScrollController _mycontroller2 =
      new ScrollController(); // for each scrollables
  ScrollController _mycontroller3 =
      new ScrollController(); // for each scrollables
  SyncScrollController _syncScroller;

  @override
  void initState() {
    super.initState();
    _syncScroller = new SyncScrollController([_mycontroller1, _mycontroller2]);

    _day0 = new DateTime.now();
    _day1 = _day0.toUtc().add(new Duration(days: 1)).toLocal();
    dayList = [_day0, _day1, _day0];
    userIds = ["a","b","c"];
    startTime = DateTime.now();
  }

  void dispose() {
    _mycontroller1.dispose();
    _mycontroller2.dispose();
    _mycontroller3.dispose();
    super.dispose();
  }

  String _minuteOfDayToHourMinuteString(int minuteOfDay) {
    return "${(minuteOfDay ~/ 60).toString().padLeft(2, "0")}"
        ":"
        "${(minuteOfDay % 60).toString().padLeft(2, "0")}";
  }

  String _minuteOfDayToHourMinuteAmPmString(int minuteOfDay) {
    return "${((minuteOfDay < 60) ? (minuteOfDay ~/ 60 + 12) : (minuteOfDay <= 60 * 12) ? (minuteOfDay ~/ 60) : (minuteOfDay ~/ 60 - 12)).toString()}"
        "${(minuteOfDay < 60 * 12) ? " AM" : (minuteOfDay == 60 * 24) ? " AM" : " PM"}";
  }

  List<StartDurationItem> _getEventsOfDay(DateTime day) {
    List<Event> events;
    if (day.year == _day0.year &&
        day.month == _day0.month &&
        day.day == _day0.day) {
      events = eventsOfDay0;
    } else {
      events = eventsOfDay1;
    }

    return events
        .map(
          (event) => new StartDurationItem(
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

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    //print("tap down " + x.toString() + ", " + y.toString());
    // print("Vertical scroll offset = ${_mycontroller1.offset}" );
    double minutes = (y + _mycontroller1.offset - 184) / 1.5;
    // print("Minutes of day = $minutes");
    print(
        "Event Day index = ${((x + _mycontroller3.offset - 64) / 140).toInt() % dayList.length}");
    int startMinute = minutes ~/ 30 * 30;
    int endMinute = ((startMinute == 30 * 47) ? 30 : 60) + startMinute;
    print("Event start minute - end minute: $startMinute - $endMinute");
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print("tap up " + x.toString() + ", " + y.toString());
  }

  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    DateTime pickedTime =
        picked.add(Duration(hours: startTime.hour, minutes: startTime.minute));
    if (picked != null && pickedTime != startTime)
      setState(() {
        startTime = pickedTime;
      });
  }
_getHeight()
{
//int maxLength = [anytimeEventsOfDay0.length, anytimeEventsOfDay1.length].reduce(max);
return 72.0;
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DayView Example"),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 105.0),
          child: Calendar(),
          /*Column(
            children: <Widget>[
              FlatButton(
                  onPressed: () => _selectStartDate(context),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(DateFormat.yMMMM("en_US").format(startTime)),
                        Icon(Icons.arrow_drop_down)
                      ])),
              new Calendarro(
                startDate: DateUtils.getFirstDayOfMonth(startTime),
                endDate: DateUtils.getLastDayOfMonth(startTime),
                selectedDate: DateUtils.toMidnight(startTime),
              ),
            ],
          ),*/
        ),
      ),
      body: new DayViewEssentials(
          properties: new DayViewProperties(days: dayList, userIds: userIds),
          child: Row(
            children: <Widget>[
              NotificationListener<ScrollNotification>(
                child: SizedBox(
                  width: 60.0,
                  child:
                  Column(
                    children: <Widget>[
                      SizedBox(height:30.0, child:IconButton(icon:Icon(Icons.group_add))),
                      SizedBox(height:_getHeight(), child:Container(
                          //decoration: BoxDecoration(border:Border.all(),
                          child:Center(child:Text("Anytime")))),
                      Expanded(
                  child:SingleChildScrollView(
                    controller: _mycontroller2,
                    child: new DayViewSchedule(
                        topExtensionHeight: 6,
                        heightPerMinute: 1.5,
                        components: <ScheduleComponent>[
                          new TimeIndicationComponent.intervalGenerated(
                            generatedTimeIndicatorBuilder:
                                _generatedTimeIndicatorBuilder,
                          ),
                        ]),
                  ),),],),
                ),
                onNotification: (ScrollNotification scrollInfo) {
                  _syncScroller.processNotification(scrollInfo, _mycontroller2);
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 60.0,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _mycontroller3,
                    child: Column(
                      children: <Widget>[
                        //Flex(direction: Axis.vertical, children: <Widget>[
                        Flexible(flex:1, child:
                        Container(
                          color: Colors.grey[200],
                          child: new DayViewDaysHeader(
                            headerItemBuilder: _headerItemBuilder,
                          ),
                        ),
                        ),
                        NotificationListener<ScrollNotification>(
                            child: Expanded(flex:5,
                              child: SingleChildScrollView(
                                controller: _mycontroller1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () => print("tapped"),
                                  onTapDown: (TapDownDetails details) =>
                                      _onTapDown(details),
                                  //  onTapUp: (TapUpDetails details) => _onTapUp(details),
                                  child: DayViewSchedule(
                                    heightPerMinute: 1.5,
                                    topExtensionHeight: 0,
                                    components: <ScheduleComponent>[
                                      new SupportLineComponent
                                          .intervalGenerated(
                                        generatedSupportLineBuilder:
                                            _generatedSupportLineBuilder,
                                      ),
                                      new DaySeparationComponent(
                                        generatedDaySeparatorBuilder:
                                            _generatedDaySeparatorBuilder,
                                      ),
                                      new EventViewComponent(
                                        getEventsOfDay: _getEventsOfDay,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onNotification: (ScrollNotification scrollInfo) {
                              _syncScroller.processNotification(
                                  scrollInfo, _mycontroller1);
                            }),
                      ],
                    )),
              ),
            ],
          )),
    );
  }

  Widget _getUserOfDay(String userId) {
    Widget userName;
      userName = Text(userId, maxLines: 1, overflow: TextOverflow.clip,);
    return userName;
  }

  Widget _getListOfAnytimeEvents(DateTime day) {
    Widget anytimeEvents;
    if (day.year == _day0.year &&
        day.month == _day0.month &&
        day.day == _day0.day) {
      anytimeEvents =
            new Column(
              children: _listofAnytimeEvents(anytimeEventsOfDay0),
            );

    } else {
      anytimeEvents =
          Column(children: _listofAnytimeEvents(anytimeEventsOfDay1));
    }
    return anytimeEvents;
  }

  List<Widget> _listofAnytimeEvents(List<Event> events) {
    List<Widget> anyTimeEvents = new List();
    events.forEach((event) {
      anyTimeEvents.add(Container(
          margin: new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 1.0),
          padding: new EdgeInsets.all(0.0),
          width: double.infinity,
          color: Colors.green[200],
          child: FlatButton(
              child: Text(
                event.title,
                maxLines:1,
                overflow: TextOverflow.ellipsis,
                style: (event.boCompleted == true)
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              onPressed: () async {
                final ConfirmAction action =
                    await _asyncConfirmDialog(context, event.title);
                print("Confirm Action $action");
              },
              color: Colors.green[200])
      )
          );
    });
    return anyTimeEvents;
  }

  Widget _headerItemBuilder(BuildContext context,  String userId) {
    return new Container(
      color: Colors.grey[300],
      padding: new EdgeInsets.symmetric(vertical: 4.0),
      child: Column(children: <Widget>[
        Flexible(flex:1, child:_getUserOfDay(userId),),
        Flexible(flex:3, child:SingleChildScrollView(child:_getListOfAnytimeEvents(day),))
      ]),
    );
  }

  Positioned _generatedTimeIndicatorBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    int minuteOfDay,
  ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width + 60.0,
      height: itemSize.height,
      child: new Container(
        child: new Center(
          child: new Text(
            _minuteOfDayToHourMinuteAmPmString(minuteOfDay),
            maxLines: 2,
          ),
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
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemWidth * 2,
      child: new Container(
        height: 0.7,
        color: (minuteOfDay % 60 == 0) ? Colors.grey[700] : Colors.grey[400],
      ),
    );
  }

  Positioned _generatedDaySeparatorBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    int daySeparatorNumber,
  ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: new Center(
        child: new Container(
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
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: new Container(
        margin: new EdgeInsets.only(left: 1.0, right: 1.0, bottom: 1.0),
        padding: new EdgeInsets.all(3.0),
        color: Colors.green[200],
        child: FlatButton(
            padding: EdgeInsets.all(0),
            child: new Text("${event.title}",
                style: (event.boCompleted == true)
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null),
            onPressed: () async {
              final ConfirmAction action =
                  await _asyncConfirmDialog(context, event.title);
              print("Confirm Action $action");
            }),
      ),
    );
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
Future<ConfirmAction> _asyncConfirmDialog(
    BuildContext context, String title) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: Text('$title selected.'),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}

class SyncScrollController {
  List<ScrollController> _registeredScrollControllers =
      new List<ScrollController>();

  ScrollController _scrollingController;
  bool _scrollingActive = false;

  SyncScrollController(List<ScrollController> controllers) {
    controllers.forEach((controller) => registerScrollController(controller));
  }

  void registerScrollController(ScrollController controller) {
    _registeredScrollControllers.add(controller);
  }

  void processNotification(
      ScrollNotification notification, ScrollController sender) {
    if (notification is ScrollStartNotification && !_scrollingActive) {
      _scrollingController = sender;
      _scrollingActive = true;
      return;
    }

    if (identical(sender, _scrollingController) && _scrollingActive) {
      if (notification is ScrollEndNotification) {
        _scrollingController = null;
        _scrollingActive = false;
        return;
      }

      if (notification is ScrollUpdateNotification) {
        _registeredScrollControllers.forEach((controller) => {
              if (!identical(_scrollingController, controller))
                controller..jumpTo(_scrollingController.offset)
            });
        return;
      }
    }
  }
}
