

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/ServiceDetailEvent.dart';
import '../Bloc/ServiceManDetailBloc.dart';
import '../Bloc/ServiceManDetailState.dart';
import '../Repositry/ServiceManDetailRepository.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceManId;

  const ServiceDetailScreen({super.key, required this.serviceManId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceDetailBloc(ServiceDetailRepository())
        ..add(FetchServiceDetail(serviceManId)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<ServiceDetailBloc, ServiceDetailState>(
            builder: (context, state) {
              if (state is ServiceDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ServiceDetailLoaded) {
                final detail = state.detail;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          detail.imageUrl,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        detail.serviceHead,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        detail.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Chip(
                            label: Text(detail.category),
                            backgroundColor: const Color(0xFFE0D7FF),
                            labelStyle: const TextStyle(color: Colors.deepPurple),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.location_pin, color: Colors.deepPurple),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(detail.location),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "PKR${detail.price}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const Text("(Minimum Price)", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 20),
                      const Text(
                        "About me",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(detail.about),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // handle booking
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is ServiceDetailError) {
                return Center(child: Text("Error: ${state.message}"));
              } else {
                return const Center(child: Text("No data"));
              }
            },
          ),
        ),
      ),
    );
  }
}
