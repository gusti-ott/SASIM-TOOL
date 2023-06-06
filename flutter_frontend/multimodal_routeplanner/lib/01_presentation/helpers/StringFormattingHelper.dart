class StringFormattingHelper {
  String convertSecondsToMinutesAndSeconds({required int totalSeconds}) {
    Duration duration = Duration(seconds: (totalSeconds * 60).toInt());
    String minutes = duration.inMinutes.toString();

    return minutes;
  }
}
