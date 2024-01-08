class TimeCalculation {
  DateTime calculateTime(double data) {
    int convertedData = data.toInt();
    DateTime dateTimeValue = DateTime.fromMillisecondsSinceEpoch(convertedData);
    return dateTimeValue;
  }
}
