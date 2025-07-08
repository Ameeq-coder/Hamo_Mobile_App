// bloc/calendar_booking_event.dart
abstract class CalendarBookingEvent {}

class CreateCalendarBookingEvent extends CalendarBookingEvent {
  final String userId;
  final String dateTime;

  CreateCalendarBookingEvent(this.userId, this.dateTime);
}
