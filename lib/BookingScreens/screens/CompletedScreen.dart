import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/AllBookingBloc.dart';
import '../bloc/AllBookingState.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<bool> isExpanded = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBookingBloc, AllBookingState>(
      builder: (context, state) {
        if (state is AllBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllBookingLoaded) {
          final bookings = state.bookings
              .where((b) => b.status.toLowerCase() == "completed")
              .toList();

          if (isExpanded.length != bookings.length) {
            isExpanded = List.generate(bookings.length, (_) => false);
          }

          if (bookings.isEmpty) {
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
                        "You have no completed booking",
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "You do not have any completed bookings.\nMake a new booking by clicking the button below.",
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
                              style:
                              TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xffF6F6F6),
            body: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return BookingCard(
                  isOpen: isExpanded[index],
                  onToggle: () {
                    setState(() {
                      isExpanded[index] = !isExpanded[index];
                    });
                  },
                  name: booking.serviceType,
                  person: booking.serviceManName,
                  dateTime: booking.bookingDateTime.toLocal().toString(),
                  location: booking.location,
                  profileUrl: booking.serviceman.detail.imageUrl,
                  status: "Completed",
                );
              },
            ),
          );
        } else if (state is AllBookingError) {
          return Center(child: Text("Error: ${state.message}"));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onToggle;
  final String name;
  final String person;
  final String dateTime;
  final String location;
  final String profileUrl;
  final String status;

  const BookingCard({
    super.key,
    required this.isOpen,
    required this.onToggle,
    required this.name,
    required this.person,
    required this.dateTime,
    required this.location,
    required this.profileUrl,
    required this.status,
  });

  Color getStatusColor(String status) {
    if (status.toLowerCase() == "completed") return Colors.green;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(profileUrl)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(person, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: getStatusColor(status).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(status,
                          style: TextStyle(
                              color: getStatusColor(status), fontSize: 11)),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {},
              )
            ],
          ),
          if (isOpen) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(child: Text(dateTime, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(child: Text(location, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("View E-Receipt",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Center(
            child: IconButton(
              icon: Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              onPressed: onToggle,
            ),
          )
        ],
      ),
    );
  }
}
