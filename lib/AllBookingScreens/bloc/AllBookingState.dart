// all_booking_state.dart
import 'package:equatable/equatable.dart';import '../models/AllBookingmodel.dart';
import 'AllBookingEvent.dart';


abstract class AllBookingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllBookingInitial extends AllBookingState {}

class AllBookingLoading extends AllBookingState {}

class AllBookingLoaded extends AllBookingState {
  final List<AllBooking> bookings;

  AllBookingLoaded(this.bookings);

  @override
  List<Object?> get props => [bookings];
}

class AllBookingError extends AllBookingState {
  final String message;

  AllBookingError(this.message);

  @override
  List<Object?> get props => [message];
}


class CompleteBookingEvent extends AllBookingEvent {
  final String bookingId;
  final String userId; // to refetch updated bookings

  CompleteBookingEvent({required this.bookingId, required this.userId});

  @override
  List<Object?> get props => [bookingId, userId];
}

class CancelBookingEvent extends AllBookingEvent {
  final String bookingId;
  final String userId; // to refetch updated bookings

  CancelBookingEvent({required this.bookingId, required this.userId});

  @override
  List<Object?> get props => [bookingId, userId];
}
