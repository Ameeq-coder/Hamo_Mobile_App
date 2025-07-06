import '../models/allservicemanmodel.dart';

abstract class AllServicemanState {}

class AllServicemanInitial extends AllServicemanState {}

class AllServicemanLoading extends AllServicemanState {}

class AllServicemanLoaded extends AllServicemanState {
  final List<AllServiceman> servicemen;

  AllServicemanLoaded(this.servicemen);
}

class AllServicemanError extends AllServicemanState {
  final String error;

  AllServicemanError(this.error);
}