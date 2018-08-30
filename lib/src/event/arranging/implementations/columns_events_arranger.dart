import 'package:meta/meta.dart';

import 'package:calendar_views/event.dart';

/// [EventsArranger] that arranges events into columns.
@immutable
class ColumnsEventsArranger implements EventsArranger {
  /// Creates a new instance of this class.
  ///
  /// If [extendColumns] is true events will be horizontally extended into neighbouring columns
  /// to fill the available space.
  const ColumnsEventsArranger({
    this.extendColumns = true,
  }) : assert(extendColumns != null);

  /// If true events will be horizontally extended to fill the available space.
  final bool extendColumns;

  @override
  List<ArrangedEvent> arrangeEvents({
    @required List<TimePositionableEvent> events,
    @required ArrangerConstraints constraints,
  }) {
    List<TimePositionableEvent> sortedEvents = <TimePositionableEvent>[];
    sortedEvents.addAll(events);
    _sortEvents(sortedEvents);

    List<_Column> columns = _makeColumns(sortedEvents);

    return _columnsToArrangedEvents(
      columns: columns,
      constraints: constraints,
      extendColumns: extendColumns,
    );
  }
}

void _sortEvents(List<TimePositionableEvent> events) {
  events.sort(
    (event1, event2) {
      if (event1.startMinuteOfDay == event2.startMinuteOfDay) {
        return event1.duration.compareTo(event2.duration);
      } else {
        return event1.startMinuteOfDay.compareTo(event2.startMinuteOfDay);
      }
    },
  );
}

List<_Column> _makeColumns(List<TimePositionableEvent> events) {
  List<_Column> columns = new List();

  columns.add(
    new _Column(),
  );

  for (TimePositionableEvent event in events) {
    _Reservation reservation = new _Reservation(event);

    bool foundColumn = false;
    for (_Column column in columns) {
      if (column.isReservationAvailable(reservation)) {
        column.addReservation(reservation);
        foundColumn = true;
        break;
      }
    }

    // event could not be placed in any of the columns, so create new column and add event into it
    if (!foundColumn) {
      columns.add(
        new _Column(),
      );
      columns.last.addReservation(reservation);
    }
  }

  return columns;
}

List<ArrangedEvent> _columnsToArrangedEvents({
  @required List<_Column> columns,
  @required ArrangerConstraints constraints,
  @required bool extendColumns,
}) {
  int determineWidthInColumns(int columnNumber, _Reservation reservation) {
    int widthInColumns = 1;

    if (extendColumns) {
      for (int i = columnNumber + 1; i < columns.length; i++) {
        _Column columnToDevour = columns[i];

        if (columnToDevour.isReservationAvailable(reservation)) {
          widthInColumns++;
        } else {
          break;
        }
      }
    }

    return widthInColumns;
  }

  List<ArrangedEvent> arrangedEvents = <ArrangedEvent>[];

  double columnWidth = constraints.areaWidth / columns.length;

  for (int columnNumber = 0; columnNumber < columns.length; columnNumber++) {
    _Column column = columns[columnNumber];

    for (_Reservation reservationInColumn in column.reservations) {
      int widthInColumns = determineWidthInColumns(
        columnNumber,
        reservationInColumn,
      );

      arrangedEvents.add(
        new ArrangedEvent(
          top: constraints.positionOfMinuteFromTop(
            reservationInColumn.event.startMinuteOfDay,
          ),
          left: columnWidth * columnNumber,
          width: columnWidth * widthInColumns,
          height:
              constraints.heightOfDuration(reservationInColumn.event.duration),
          event: reservationInColumn.event,
        ),
      );
    }
  }

  return arrangedEvents;
}

@immutable
class _Reservation {
  _Reservation(
    this.event,
  ) : assert(event != null);

  final TimePositionableEvent event;

  int get fromMinute => event.startMinuteOfDay;

  int get toMinute => event.startMinuteOfDay + event.duration;
}

class _Column {
  List<_Reservation> reservations = new List();

  bool isReservationAvailable(_Reservation reservation) {
    for (_Reservation alreadyPlacedReservation in reservations) {
      if (!(reservation.toMinute <= alreadyPlacedReservation.fromMinute ||
          reservation.fromMinute >= alreadyPlacedReservation.toMinute)) {
        return false;
      }
    }

    return true;
  }

  void addReservation(_Reservation reservation) {
    reservations.add(reservation);
  }
}
