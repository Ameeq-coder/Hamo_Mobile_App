// Bloc: all_serviceman_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositry/AllServicemanRepository.dart';
import 'AllServiceEvent.dart';
import 'AllServiceManState.dart';


class AllServicemanBloc extends Bloc<AllServicemanEvent, AllServicemanState> {
  final AllServicemanRepository repository;

  AllServicemanBloc(this.repository) : super(AllServicemanInitial()) {
    on<FetchAllServicemanByLocation>((event, emit) async {
      emit(AllServicemanLoading());
      try {
        final servicemen = await repository.getServicemenByLocation(event.location);
        emit(AllServicemanLoaded(servicemen));
      } catch (e) {
        emit(AllServicemanError(e.toString()));
      }
    });
  }
}
