import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../Details/repositry/user_detail_repository.dart';
import '../repositry/HomeUserDetailRepo.dart';
import 'HomeUserDetailState.dart';
import 'homeuserevent.dart';

class HomeUserDetailBloc extends Bloc<HomeUserDetailEvent, HomeUserDetailState> {
  final HomeUserDetailRepository repository;

  HomeUserDetailBloc(this.repository) : super(UserDetailInitial()) {
    on<FetchUserDetail>((event, emit) async {
      emit(UserDetailLoading()); // ✅ Show loading state
      try {
        final userDetail = await repository.fetchUserDetails(event.userId);

        final box = Hive.box('userBox');
        box.put('address', userDetail.address);
        box.put('username', userDetail.name);

        emit(UserDetailLoaded(userDetail)); // ✅ Pass the required argument
      } catch (e) {
        emit(UserDetailError(e.toString()));
      }
    });
  }
}
