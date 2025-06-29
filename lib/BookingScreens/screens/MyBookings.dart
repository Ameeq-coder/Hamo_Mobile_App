import 'package:flutter/material.dart';

import '../../Common/BottomSheet.dart';
import 'CacelledScreen.dart';
import 'CompletedScreen.dart';
import 'UpcomingScreen.dart';



class MyBookingMain extends StatelessWidget {
  const MyBookingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 2, // Select "Cancelled" by default
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My Bookings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.black),
                        SizedBox(width: 16),
                        Icon(Icons.more_vert, color: Colors.black),
                      ],
                    )
                  ],
                ),
              ),
              const TabBar(
                labelColor: Colors.purple,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.purple,
                tabs: [
                  Tab(text: "Upcoming"),
                  Tab(text: "Completed"),
                  Tab(text: "Cancelled"),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    UpcomingScreen(),
                    CompletedScreen(),
                    CancelledScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:  BottomNavigation(currentIndex: 0,),
      ),
    );
  }
}
