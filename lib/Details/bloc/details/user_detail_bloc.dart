import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositry/user_detail_repository.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository repository;

  UserDetailBloc(this.repository) : super(UserDetailInitial()) {
    on<SubmitUserDetailsEvent>((event, emit) async {
      emit(UserDetailLoading());
      try {
        final user = await repository.submitUserDetails(
          userId: event.userId,
          name: event.name,
          dob: event.dob,
          phone: event.phone,
          address: event.address,
          image: event.image,
        );
        emit(UserDetailSuccess(user));
      } catch (e) {
        emit(UserDetailFailure(e.toString()));
      }
    });
  }
}
