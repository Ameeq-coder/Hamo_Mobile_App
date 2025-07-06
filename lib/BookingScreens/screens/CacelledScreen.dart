import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/AllBookingBloc.dart';
import '../bloc/AllBookingState.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  List<bool> isExpanded = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBookingBloc, AllBookingState>(
      builder: (context, state) {
        if (state is AllBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllBookingLoaded) {
          final cancelledBookings = state.bookings
              .where((booking) => booking.status.toLowerCase() == 'cancelled')
              .toList();

          if (cancelledBookings.isEmpty) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/NoBooking.PNG', height: 200),
                      const SizedBox(height: 20),
                      const Text(
                        "You have no cancelled booking",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "You do not have any cancelled bookings.\nMake a new booking by clicking the button below.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: navigate to booking screen
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Make New Booking",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          if (isExpanded.length != cancelledBookings.length) {
            isExpanded = List.generate(cancelledBookings.length, (_) => false);
          }

          return Scaffold(
            backgroundColor: const Color(0xffF6F6F6),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cancelledBookings.length,
              itemBuilder: (context, index) {
                final item = cancelledBookings[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150?u=${item.servicemanId}'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.serviceType,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(item.serviceManName,
                                    style: const TextStyle(fontSize: 12)),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text("Cancelled",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 11)),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.message,
                                size: 20, color: Colors.purple),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.black54),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.bookingDateTime
                                  .toLocal()
                                  .toString()
                                  .replaceFirst('T', ' '),
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.black54),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(item.location,
                                style: const TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is AllBookingError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
