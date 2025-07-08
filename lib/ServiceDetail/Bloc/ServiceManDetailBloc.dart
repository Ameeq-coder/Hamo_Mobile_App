import 'package:flutter_bloc/flutter_bloc.dart';
import '../Repositry/ServiceManDetailRepository.dart';
import 'ServiceDetailEvent.dart';
import 'ServiceManDetailState.dart';

class ServiceDetailBloc extends Bloc<ServiceDetailEvent, ServiceDetailState> {
  final ServiceDetailRepository repository;

  ServiceDetailBloc(this.repository) : super(ServiceDetailInitial()) {
    on<FetchServiceDetail>((event, emit) async {
      emit(ServiceDetailLoading());
      try {
        final detail = await repository.fetchServiceDetail(event.serviceManId);
        emit(ServiceDetailLoaded(detail));
      } catch (e) {
        emit(ServiceDetailError(e.toString()));
      }
    });
  }
}
