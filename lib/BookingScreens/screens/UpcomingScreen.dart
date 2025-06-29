import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  List<bool> isExpanded = [true, true]; // can be dynamic based on items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 2,
        itemBuilder: (context, index) {
          return BookingCard(
            isOpen: isExpanded[index],
            onToggle: () {
              setState(() {
                isExpanded[index] = !isExpanded[index];
              });
            },
            name: index == 0 ? "House Cleaning" : "Garage Cleaning",
            person: index == 0 ? "Jenny Wilson" : "Florencio Dorrance",
            dateTime: index == 0
                ? "Dec 23, 2024 | 10:00 - 12:00 AM"
                : "Dec 20, 2024 | 09:00 - 11:00 AM",
            location: index == 0
                ? "267 New Avenue Park, New York"
                : "65220 Holy Cross Pass",
            profileUrl: "https://i.pravatar.cc/150?img=${index + 1}", // sample avatar
          );
        },
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

  const BookingCard({
    super.key,
    required this.isOpen,
    required this.onToggle,
    required this.name,
    required this.person,
    required this.dateTime,
    required this.location,
    required this.profileUrl,
  });

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
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(person, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Upcoming",
                          style: TextStyle(color: Colors.purple, fontSize: 11)),
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
                child: const Icon(
                  Icons.message,
                  color: Colors.purple,
                  size: 20,
                ),
              ),

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
              child: const Center(child: Icon(Icons.location_pin, size: 48, color: Colors.purple)),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Cancel Booking", style: TextStyle(color: Colors.purple)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
