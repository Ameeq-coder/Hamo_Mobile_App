// all_booking_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/AllBookingRepo.dart';
import 'AllBookingEvent.dart';
import 'AllBookingState.dart';

class AllBookingBloc extends Bloc<AllBookingEvent, AllBookingState> {
  final AllBookingRepository repository;

  AllBookingBloc(this.repository) : super(AllBookingInitial()) {
    on<FetchAllBookings>((event, emit) async {
      emit(AllBookingLoading());
      try {
        final bookings = await repository.fetchAllBookings(event.userId);
        emit(AllBookingLoaded(bookings));
      } catch (e) {
        emit(AllBookingError(e.toString()));
      }
    });
  }
}
