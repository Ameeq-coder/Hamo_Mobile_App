abstract class CreateBookingEvent {}

class SubmitCreateBooking extends CreateBookingEvent {
  final Map<String, dynamic> bookingData;

  SubmitCreateBooking(this.bookingData);
}
