extension TimeFormatExtension on DateTime {
  String toTimeFormat() {
    return "${this.hourOfPeriod.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')} ${this.period}";
  }

  String get period => this.hour >= 12 ? 'PM' : 'AM';

  int get hourOfPeriod => this.hour % 12 == 0 ? 12 : this.hour % 12;
}
