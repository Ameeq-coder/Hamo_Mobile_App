// bloc/all_servicemen_location_and_cat_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Repositry/ServicemanRepository.dart';
import 'FetchServicemenEvent.dart';
import 'ServicemanState.dart';


class AllServicemenLocationAndCatBloc extends Bloc<AllServicemenLocationAndCatEvent, AllServicemenLocationAndCatState> {
  final AllServicemenLocationAndCatRepository repository;

  AllServicemenLocationAndCatBloc(this.repository) : super(AllServicemenLocationAndCatInitial()) {
    on<FetchAllServicemenLocationAndCat>((event, emit) async {
      emit(AllServicemenLocationAndCatLoading());
      try {
        final servicemen = await repository.fetchServicemen(event.category, event.location);
        emit(AllServicemenLocationAndCatLoaded(servicemen));
      } catch (e) {
        emit(AllServicemenLocationAndCatError(e.toString()));
      }
    });
  }
}
