import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable {
  const UserDetailEvent();
  @override
  List<Object> get props => [];
}

class SubmitUserDetailsEvent extends UserDetailEvent {
  final String userId;
  final String name;
  final String dob;
  final String phone;
  final String address;
  final File image;

  const SubmitUserDetailsEvent({
    required this.userId,
    required this.name,
    required this.dob,
    required this.phone,
    required this.address,
    required this.image,
  });

  @override
  List<Object> get props => [userId, name, dob, phone, address, image];
}
