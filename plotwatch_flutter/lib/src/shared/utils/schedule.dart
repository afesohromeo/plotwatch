import 'package:plotwatch_flutter/plotwatch_flutter.dart';

/// Schedule status (STG-10, doc/04e M5-10). Planned dates are calendar days
/// (stored at UTC midnight); "today" and capture times are local. Lateness
/// is about the schedule and never changes a verification badge.
extension StageScheduleX on Stage {
  /// Past its planned end and not approved yet.
  bool isLateOn(DateTime now) {
    final end = plannedEnd;
    if (end == null || status == StageStatus.approved) return false;
    return _day(now).isAfter(_plannedDay(end));
  }
}

/// How many days after [plannedEnd] a photo taken at [capturedAt] was
/// taken, or null when it wasn't after it (or there is no planned end).
int? daysAfterPlannedEnd(DateTime capturedAt, DateTime? plannedEnd) {
  if (plannedEnd == null) return null;
  final days = _day(capturedAt).difference(_plannedDay(plannedEnd)).inDays;
  return days > 0 ? days : null;
}

/// The local calendar day of [time], at midnight.
DateTime _day(DateTime time) {
  final local = time.toLocal();
  return DateTime(local.year, local.month, local.day);
}

/// A planned date is a calendar day stored at UTC midnight.
DateTime _plannedDay(DateTime planned) =>
    DateTime(planned.year, planned.month, planned.day);
