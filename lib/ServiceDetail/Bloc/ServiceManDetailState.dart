
import '../Models/ServiceManDetailModel.dart';

abstract class ServiceDetailState {}

class ServiceDetailInitial extends ServiceDetailState {}

class ServiceDetailLoading extends ServiceDetailState {}

class ServiceDetailLoaded extends ServiceDetailState {
  final ServiceDetail detail;

  ServiceDetailLoaded(this.detail);
}

class ServiceDetailError extends ServiceDetailState {
  final String message;

  ServiceDetailError(this.message);
}
