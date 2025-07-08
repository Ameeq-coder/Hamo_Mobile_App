import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamo/Calender/Repositry/CalendarBookingRepository.dart';
import 'CalendarBookingEvent.dart';
import 'CalendarBookingState.dart';


class CalendarBookingBloc extends Bloc<CalendarBookingEvent, CalendarBookingState> {
  final CalendarBookingRepository repository;

  CalendarBookingBloc(this.repository) : super(CalendarBookingInitial()) {
    on<CreateCalendarBookingEvent>((event, emit) async {
      emit(CalendarBookingLoading());
      try {
        final bookings = await repository.createBooking(event.userId, event.dateTime);
        emit(CalendarBookingSuccess(bookings));
      } catch (e) {
        emit(CalendarBookingError(e.toString()));
      }
    });
  }
}
