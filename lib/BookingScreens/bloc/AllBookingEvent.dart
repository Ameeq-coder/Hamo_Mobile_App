// all_booking_event.dart
import 'package:equatable/equatable.dart';

abstract class AllBookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllBookings extends AllBookingEvent {
  final String userId;

  FetchAllBookings(this.userId);

  @override
  List<Object?> get props => [userId];
}
