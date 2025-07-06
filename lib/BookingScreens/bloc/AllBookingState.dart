// all_booking_state.dart
import 'package:equatable/equatable.dart';import '../models/AllBookingmodel.dart';


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
