import 'package:intl/intl.dart';

class TimeCalculation {
  String convertMillisecondsToDateTime(double milliseconds) {
    int convertedMilliseconds = milliseconds.toInt() * 1000;
    DateTime dateTimeValue =
        DateTime.fromMillisecondsSinceEpoch(convertedMilliseconds);

    String formatedDateTime = DateFormat("HH:mm").format(dateTimeValue);

    return formatedDateTime;
  }
}
