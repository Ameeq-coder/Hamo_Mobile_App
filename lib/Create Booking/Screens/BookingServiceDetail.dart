import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamo/Create%20Booking/Screens/BookingDetailScreen.dart';
import '../BLOC/CreateBookingBloc.dart';
import '../Repositry/CreateBookingRepository.dart';

class BookingServiceDetail extends StatelessWidget {
  final String userid;
  final String username;
  final String servicemanId;
  final String serviceManName;
  final String servicetype;
  final int price;

  const BookingServiceDetail({
    super.key,
    required this.userid,
    required this.username,
    required this.servicemanId,
    required this.serviceManName,
    required this.servicetype,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController serviceController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Service Input'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Service you want',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: serviceController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Service you need',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => CreateBookingBloc(CreateBookingRepository()),
                        child: BookingDetailsScreen(
                          userid: userid,
                          username: username,
                          servicemanId: servicemanId,
                          serviceManName: serviceManName,
                          servicetype: servicetype,
                          price: price,
                          serviceDescription: serviceController.text,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
