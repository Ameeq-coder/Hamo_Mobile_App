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
  }
}
