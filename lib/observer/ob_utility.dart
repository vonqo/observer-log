class ObUtility {

  static String getLogName(DateTime time) {
    return 'obs_${time.year}_${putZero(time.month)}_${putZero(time.day)}.log';
  }

  static String putZero(int a) {
    if(a < 10) return '0$a';
    return a.toString();
  }

  static bool isLogFile(String fileName) {
    RegExp exp = RegExp('obs_[0-9]{1,4}_[0-9]{1,2}_[0-9]{1,2}.log');
    String? match = exp.stringMatch(fileName);
    return match != null;
  }

  static DateTime getLogDate(String fileName) {
    String year = fileName.substring(4,8);
    String month = fileName.substring(9,11);
    String day = fileName.substring(12,14);
    return DateTime.parse('$year-$month-$day');
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }



}