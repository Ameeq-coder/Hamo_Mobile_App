import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repositry/CreateBookingRepository.dart';
import 'CreateBookingEvent.dart';
import 'CreateBookingState.dart';

class CreateBookingBloc extends Bloc<CreateBookingEvent, CreateBookingState> {
  final CreateBookingRepository repository;

  CreateBookingBloc(this.repository) : super(CreateBookingInitial()) {
    on<SubmitCreateBooking>((event, emit) async {
      emit(CreateBookingLoading());
      try {
        final booking = await repository.createBooking(event.bookingData);
        emit(CreateBookingSuccess(booking));
      } catch (e) {
        emit(CreateBookingFailure(e.toString()));
      }
    });

    on<FetchAvailableTimeSlots>((event, emit) async {
      emit(TimeSlotLoading());
      try {
        final slots = await repository.getAvailableTimeSlots(event.servicemanId, event.date);
        emit(TimeSlotLoaded(slots));
      } catch (e) {
        emit(TimeSlotError(e.toString()));
      }
    });


  }




}


