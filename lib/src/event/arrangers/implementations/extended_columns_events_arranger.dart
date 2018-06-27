import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:calendar_views/calendar_items.dart';

import 'package:calendar_views/src/event/events/positionable_event.dart';
import '../arranged_event.dart';
import '../arranger_constraints.dart';
import '../events_arranger.dart';

class ExtendedColumnsEventsArranger implements EventsArranger {
  const ExtendedColumnsEventsArranger();

  @override
  List<ArrangedEvent> arrangeEvents({
    @required Set<PositionableEvent> events,
    @required ArrangerConstraints constraints,
  }) {
    List<PositionableEvent> eventsToArrange = events.toList();

    // sorts events
    sortPositionableEvents(eventsToArrange);

    // makes columns
    List<_Column> columns = _makeColumns(eventsToArrange);

    // makes positionedEvents
    List<ArrangedEvent> positionedEvents = _columnsToPositionedEvents(
      columns,
      constraints,
    );

    return positionedEvents;
  }
}

List<_Column> _makeColumns(List<PositionableEvent> events) {
  List<_Column> columns = new List();

  columns.add(
    new _Column(),
  );

  for (PositionableEvent event in events) {
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

/// Turns columns into positioned events.
List<ArrangedEvent> _columnsToPositionedEvents(
  List<_Column> columns,
  ArrangerConstraints constraints,
) {
  List<ArrangedEvent> positionedEvents = <ArrangedEvent>[];

  double columnWidth = constraints.areaWidth / columns.length;

  for (int columnNumber = 0; columnNumber < columns.length; columnNumber++) {
    _Column column = columns[columnNumber];

    for (_Reservation reservationInColumn in column.reservations) {
      int widthInColumns = 1;
      for (int i = columnNumber + 1; i < columns.length; i++) {
        _Column columnToDevour = columns[i];

        if (columnToDevour.isReservationAvailable(reservationInColumn)) {
          widthInColumns++;
        } else {
          break;
        }
      }

      Position position = new Position(
        top:
            constraints.positionTop(reservationInColumn.event.beginMinuteOfDay),
        left: (columnWidth * columnNumber) + constraints.areaLeft,
      );

      Size size = new Size(
        columnWidth * widthInColumns,
        constraints.height(reservationInColumn.event.duration),
      );

      positionedEvents.add(
        new ArrangedEvent(
          position: position,
          size: size,
          event: reservationInColumn.event,
        ),
      );
    }
  }

  return positionedEvents;
}

@immutable
class _Reservation {
  _Reservation(
    this.event,
  ) : assert(event != null);

  final PositionableEvent event;

  int get fromMinute => event.beginMinuteOfDay;

  int get toMinute => event.beginMinuteOfDay + event.duration;
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
