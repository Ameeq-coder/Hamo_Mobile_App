import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamo/Authentication/Screens/Signup.dart';
import 'package:hamo/Authentication/bloc/auth/auth_bloc.dart';
import 'package:hamo/Authentication/repository/auth_repository.dart';

import 'BookingScreens/screens/MyBookings.dart';
import 'Details/Screens/UserDetailScreen.dart';
import 'Services/Screens/AllServiceScreen.dart';
import 'Home/Screens/Home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
