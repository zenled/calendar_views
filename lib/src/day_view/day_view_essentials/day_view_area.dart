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

bool isNumberedDayViewArea(DayViewArea area) {
  return area == DayViewArea.dayArea || area == DayViewArea.daySeparationArea;
}
