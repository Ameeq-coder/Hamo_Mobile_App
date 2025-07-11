import '../Models/CreateBooking.dart';

abstract class CreateBookingState {}

class CreateBookingInitial extends CreateBookingState {}

class CreateBookingLoading extends CreateBookingState {}

class CreateBookingSuccess extends CreateBookingState {
  final CreateBooking booking;

  CreateBookingSuccess(this.booking);
}

class CreateBookingFailure extends CreateBookingState {
  final String error;

  CreateBookingFailure(this.error);
}
