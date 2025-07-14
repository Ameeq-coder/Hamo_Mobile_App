// bloc/all_servicemen_location_and_cat_state.dart

import '../Models/ServiceManModel.dart';

abstract class AllServicemenLocationAndCatState {}

class AllServicemenLocationAndCatInitial extends AllServicemenLocationAndCatState {}

class AllServicemenLocationAndCatLoading extends AllServicemenLocationAndCatState {}

class AllServicemenLocationAndCatLoaded extends AllServicemenLocationAndCatState {
  final List<AllServicemenLocationAndCat> servicemen;

  AllServicemenLocationAndCatLoaded(this.servicemen);
}

class AllServicemenLocationAndCatError extends AllServicemenLocationAndCatState {
  final String message;

  AllServicemenLocationAndCatError(this.message);
}
