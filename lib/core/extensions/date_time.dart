import 'package:intl/intl.dart';

extension TimeFormatExtension on DateTime {
  String toTimeFormat() {
    return "${this.hourOfPeriod.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')} ${this.period}";
  }

  String get period => this.hour >= 12 ? 'PM' : 'AM';

  int get hourOfPeriod => this.hour % 12 == 0 ? 12 : this.hour % 12;

  String toCustomFormattedString() {
    final now = DateTime.now();
    final difference = now.difference(this);

    // Formatter for time (e.g., 07:30 AM)
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('dd/MM/yy');

    if (difference.inDays == 0 && now.day == this.day) {
      // Today
      return "Today, ${timeFormat.format(this)}";
    } else if (difference.inDays == 1 ||
        (difference.inDays == 0 && now.day != this.day)) {
      // Yesterday
      return "Yesterday, ${timeFormat.format(this)}";
    } else if (difference.inDays < 7) {
      // Within the last week
      final weekdayFormat =
          DateFormat('EEEE'); // Returns day name (e.g., Monday)
      return "${weekdayFormat.format(this)}, ${timeFormat.format(this)}";
    } else {
      // Older dates
      return "${dateFormat.format(this)}, ${timeFormat.format(this)}";
    }
  }
}
