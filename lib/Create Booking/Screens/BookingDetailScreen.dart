import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Home/Screens/Home.dart';
import '../BLOC/CreateBookingBloc.dart';
import '../BLOC/CreateBookingEvent.dart';
import '../BLOC/CreateBookingState.dart';
import '../Repositry/CreateBookingRepository.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String userid;
  final String username;
  final String servicemanId;
  final String serviceManName;
  final String servicetype;
  final int price;
  final String serviceDescription;

  const BookingDetailsScreen({
    super.key,
    required this.userid,
    required this.username,
    required this.servicemanId,
    required this.serviceManName,
    required this.servicetype,
    required this.price,
    required this.serviceDescription,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedStartIndex = 0;
  int selectedEndIndex = 1;

  List<String> timeSlots = [
    '08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM',
    '12:00 PM', '01:00 PM', '02:00 PM', '03:00 PM',
    '04:00 PM', '05:00 PM', '06:00 PM',
  ];

  TextEditingController locationController = TextEditingController();

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateBookingBloc(CreateBookingRepository()),
      child: BlocListener<CreateBookingBloc, CreateBookingState>(
        listener: (context, state) {
          if (state is CreateBookingSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("✅ Booking Created Successfully!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Home()),
            );
          } else if (state is CreateBookingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("❌ Error: ${state.error}")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Booking Details'),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const BackButton(color: Colors.black),
          ),
          body: BlocBuilder<CreateBookingBloc, CreateBookingState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select Date",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2E9FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.yMMMM().format(selectedDate),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              CalendarDatePicker(
                                initialDate: selectedDate,
                                firstDate: DateTime(2024, 1),
                                lastDate: DateTime(2026, 1),
                                onDateChanged: onDateSelected,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextField(
                          controller: locationController,
                          decoration: InputDecoration(
                            hintText: "Enter Location",
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Text("Choose Start Time", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: timeSlots.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return ChoiceChip(
                                label: Text(timeSlots[index]),
                                selected: selectedStartIndex == index,
                                onSelected: (_) {
                                  setState(() => selectedStartIndex = index);
                                },
                                selectedColor: Colors.deepPurple,
                                labelStyle: TextStyle(
                                  color: selectedStartIndex == index ? Colors.white : Colors.black,
                                ),
                                backgroundColor: const Color(0xFFF5F0FF),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        const Text("Choose End Time", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: timeSlots.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              return ChoiceChip(
                                label: Text(timeSlots[index]),
                                selected: selectedEndIndex == index,
                                onSelected: (_) {
                                  setState(() => selectedEndIndex = index);
                                },
                                selectedColor: Colors.deepPurple,
                                labelStyle: TextStyle(
                                  color: selectedEndIndex == index ? Colors.white : Colors.black,
                                ),
                                backgroundColor: const Color(0xFFF5F0FF),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            final bookingData = {
                              'servicemanId': widget.servicemanId,
                              'serviceManName': widget.serviceManName,
                              'userId': widget.userid,
                              'userName': widget.username,
                              'serviceType': widget.servicetype,
                              'serviceOptions': {
                                'description': widget.serviceDescription,
                              },
                              'location': locationController.text,
                              'paid': false,
                              'status': 'upcoming',
                              'bookingDateTime': selectedDate.toIso8601String(),
                              'startTime': timeSlots[selectedStartIndex],
                              'endTime': timeSlots[selectedEndIndex],
                              'price': widget.price,
                            };

                            BlocProvider.of<CreateBookingBloc>(context)
                                .add(SubmitCreateBooking(bookingData));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Continue - \$${widget.price.toStringAsFixed(0)}",
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is CreateBookingLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
