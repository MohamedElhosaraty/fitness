class GetTodayName {
  GetTodayName._();

  static const List<String> weekDayNames = [
    'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];

  static String get todayName => weekDayNames[DateTime.now().weekday - 1];
  static int get todayIndex => DateTime.now().weekday - 1;
}