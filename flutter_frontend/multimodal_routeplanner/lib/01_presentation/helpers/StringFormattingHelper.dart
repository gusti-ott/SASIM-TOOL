class StringFormattingHelper {
  String convertSecondsToMinutesAndSeconds({required double totalMinutes}) {
    Duration duration = Duration(minutes: totalMinutes.round());
    String minutes = duration.inMinutes.toString();

    return minutes;
  }
}
