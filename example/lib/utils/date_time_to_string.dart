String dateToString(DateTime date) {
  return "${date.year.toString().padLeft(4, "0")}."
      "${date.month.toString().padLeft(2, "0")}."
      "${date.day.toString().padLeft(2, "0")}";
}

String yearAndMonthToString(DateTime month) {
  return "${month.year.toString().padLeft(4, "0")}."
      "${month.month.toString().padLeft(2, "0")}";
}
