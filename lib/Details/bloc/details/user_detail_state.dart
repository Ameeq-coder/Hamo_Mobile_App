import 'package:equatable/equatable.dart';

import '../../models/UserDetailModel.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();
  @override
  List<Object?> get props => [];
}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailSuccess extends UserDetailState {
  final UserDetailModel userDetails;
  const UserDetailSuccess(this.userDetails);
  @override
  List<Object?> get props => [userDetails];
}

class UserDetailFailure extends UserDetailState {
  final String error;
  const UserDetailFailure(this.error);
  @override
  List<Object?> get props => [error];
}
