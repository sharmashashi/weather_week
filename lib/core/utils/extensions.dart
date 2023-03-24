// const Map<String, String> _days = {
//   '1': 'Monday',
//   '2': 'Tuesday',
//   '3': 'Wednesday',
//   '4': 'Thursday',
//   '5': 'Friday',
//   '6': 'Saturday',
//   '7': 'Sunday'
// };

const List<String> _days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const List<String> _months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

extension DateParsing on DateTime {
  String? get dayName => _days[weekday - 1];

  String? get monthName => _months[month - 1];
}
