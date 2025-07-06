import '../models/HomeUserDetail.dart';

abstract class HomeUserDetailState {}

class UserDetailInitial extends HomeUserDetailState {}

class UserDetailLoading extends HomeUserDetailState {}

class UserDetailLoaded extends HomeUserDetailState {
  final HomeUserDetail userDetail;

  UserDetailLoaded(this.userDetail);
}

class UserDetailError extends HomeUserDetailState {
  final String message;

  UserDetailError(this.message);
}
