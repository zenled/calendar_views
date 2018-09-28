/// Enum with all of the areas in a day view.
enum DayViewArea {
  totalArea,
  startTotalArea,
  endTotalArea,
  contentArea,
  timeIndicationArea,
  separationArea,
  mainArea,
  startMainArea,
  endMainArea,
  eventArea,
  dayArea,
  daySeparationArea,
}

/// Returns true if [area] is a non-numbered area.
///
/// Non-numbered area is an area that only appears once inside a day view.
bool isNonNumberedDayViewArea(DayViewArea area) {
  return area == DayViewArea.totalArea ||
      area == DayViewArea.startTotalArea ||
      area == DayViewArea.endTotalArea ||
      area == DayViewArea.contentArea ||
      area == DayViewArea.timeIndicationArea ||
      area == DayViewArea.separationArea ||
      area == DayViewArea.mainArea ||
      area == DayViewArea.startMainArea ||
      area == DayViewArea.endMainArea ||
      area == DayViewArea.eventArea;
}

/// Returns true if [area] is a numbered area.
///
/// Numbered area is an area that can appear multiple times inside a day view.
/// Each numbered area is assigned a number.
bool isNumberedDayViewArea(DayViewArea area) {
  return area == DayViewArea.dayArea || area == DayViewArea.daySeparationArea;
}
