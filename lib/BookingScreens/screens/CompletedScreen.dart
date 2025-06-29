import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<bool> isExpanded = [true, false]; // control for each card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BookingCard(
              isOpen: isExpanded[0],
              onToggle: () {
                setState(() {
                  isExpanded[0] = !isExpanded[0];
                });
              },
              name: "Home Cleaning",
              person: "Maryland Wrinkles",
              dateTime: "Dec 12, 2024 | 13:00 - 15:00 PM",
              location: "1691 Carpenter Pass",
              profileUrl: "https://i.pravatar.cc/150?img=12",
              status: "Completed",
            ),
            BookingCard(
              isOpen: isExpanded[1],
              onToggle: () {
                setState(() {
                  isExpanded[1] = !isExpanded[1];
                });
              },
              name: "Laundry Services",
              person: "Aileen Fullbright",
              dateTime: "Dec 08, 2024 | 09:00 - 11:00 AM",
              location: "08009 Anhalt Alley",
              profileUrl: "https://i.pravatar.cc/150?img=5",
              status: "Completed",
            ),
          ],
        ),
      ),
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
    if (status == "Completed") return Colors.green;
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
          // Top row
          Row(
            children: [
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(profileUrl)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(person, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: getStatusColor(status).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(status,
                          style: TextStyle(color: getStatusColor(status), fontSize: 11)),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  // Handle message
                },
              )
            ],
          ),

          if (isOpen) ...[
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(child: Text(dateTime, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(child: Text(location, style: const TextStyle(fontSize: 13))),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.location_pin, size: 48, color: Colors.purple),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // View e-receipt action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("View E-Receipt",style: TextStyle(
                  color: Colors.white
                ),),
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
