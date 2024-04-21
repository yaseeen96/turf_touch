import 'package:logger/logger.dart';

String convertTo12HourFormat(String timeSlot) {
  return timeSlot.split('-').map((time) {
    int hour = int.parse(time);
    String suffix = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12; // Handle midnight and noon
    return "$hour $suffix";
  }).join(' - ');
}

final logger = Logger();
