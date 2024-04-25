import 'package:calendar_time/calendar_time.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

extension ListExtension on List {
  bool isEqual(List<Object> others) {
    if (this.length != others.length) {
      return false;
    }

    return this
        .every((element1) => others.any((element2) => element1 == element2));
  }
}

extension DateExtension on DateTime {
  String toHumanRedable() {
    if (CalendarTime(DateTime.now().add(Duration(days: -1))).startOfDay ==
        CalendarTime(this).startOfDay) {
      return "Yesterday";
    }

    if (this.isBefore(CalendarTime(DateTime.now()).startOfDay)) {
      return CalendarTime(this).format("MMMM dd, yyyy");
    }

    if (this.isAfter(DateTime.now().add(Duration(days: 7)))) {
      return CalendarTime(this).format("MMMM dd, yyyy");
    }

    return CalendarTime(this).toHumanArray[0];
  }
}
