extension DateTimeExtension on DateTime {
  String toTimeOrDate() {
    final now = DateTime.now();

    if (year == now.year && month == now.month && day == now.day) {
      return toTimeString();
    } else if (year == now.year) {
      return '$month월 $day일';
    } else {
      return '$year.$month.$day';
    }
  }

  String toTimeString() {
    String ap = hour < 12 ? '오전' : '오후';
    String hh = hour == 0 ? '12' : hour > 12 ? '${hour % 12}' : '$hour';
    String mm = minute < 10 ? '0$minute' : '$minute';

    return '$ap $hh:$mm';
  }

  String toDateString() {
    return '$year년 $month월 $day일';
  }

  bool isDateSame(DateTime time) {
    return year == time.year && month == time.month && day == time.day;
  }

  bool isTimeSame(DateTime time) {
    return year == time.year &&
        month == time.month &&
        day == time.day &&
        hour == time.hour &&
        minute == time.minute;
  }
}