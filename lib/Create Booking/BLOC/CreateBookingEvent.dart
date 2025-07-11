abstract class CreateBookingEvent {}

class SubmitCreateBooking extends CreateBookingEvent {
  final Map<String, dynamic> bookingData;

  SubmitCreateBooking(this.bookingData);
}


class FetchAvailableTimeSlots extends CreateBookingEvent {
  final String servicemanId;
  final String date;
  FetchAvailableTimeSlots(this.servicemanId, this.date);
}