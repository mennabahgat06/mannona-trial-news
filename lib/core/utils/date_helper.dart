/// Small date helpers (no extra package needed).
class DateHelper {
  static const List<String> _days = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December',
  ];

  /// "Good Morning" / "Good Afternoon" / "Good Evening".
  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }

  /// Example: "Tue 29 September, 2026".
  static String today() {
    final now = DateTime.now();
    return '${_days[now.weekday - 1]} ${now.day} ${_months[now.month - 1]}, ${now.year}';
  }

  /// Turns "2026-09-29T10:00:00Z" into "29 September 2026".
  static String formatApiDate(String? value) {
    if (value == null || value.isEmpty) return 'Recent';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
  }
}
