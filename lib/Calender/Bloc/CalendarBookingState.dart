import '../MODEL/CalendarBooking.dart';

abstract class CalendarBookingState {}

class CalendarBookingInitial extends CalendarBookingState {}

class CalendarBookingLoading extends CalendarBookingState {}

class CalendarBookingSuccess extends CalendarBookingState {
  final List<CalendarBooking> bookings;

  CalendarBookingSuccess(this.bookings);
}

class CalendarBookingError extends CalendarBookingState {
  final String message;

  CalendarBookingError(this.message);
}
