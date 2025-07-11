import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamo/Authentication/Screens/Login.dart';
import 'package:hamo/Authentication/Screens/Signup.dart';
import 'package:hamo/Authentication/bloc/auth/auth_bloc.dart';
import 'package:hamo/Authentication/repository/auth_repository.dart';

import 'Authentication/bloc/auth/Login_Bloc.dart';
import 'Calender/Bloc/CalendarBookingBloc.dart';
import 'Calender/Repositry/CalendarBookingRepository.dart';
import 'Calender/calenderscreen.dart';
import 'Create Booking/Screens/BookingDetailScreen.dart';
import 'Create Booking/Screens/BookingServiceDetail.dart';
import 'Details/Screens/UserDetailScreen.dart';
import 'Profile/Profile.dart';
import 'Profile/Repositry/profile_repository.dart';
import 'Profile/bloc/profile_bloc.dart';
import 'Services/Screens/AllServiceScreen.dart';
import 'Home/Screens/Home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(AuthRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Home(),
      ),
    );
  }
}
