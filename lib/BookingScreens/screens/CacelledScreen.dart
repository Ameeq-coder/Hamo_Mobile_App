import 'package:flutter/material.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  final List<Map<String, String>> cancelledItems = const [
    {
      'title': 'Plumbing Repair',
      'name': 'Chantal Shelburne',
      'image': 'https://i.imgur.com/1O1bEZp.png'
    },
    {
      'title': 'Appliance Service',
      'name': 'Benny Spanbauer',
      'image': 'https://i.imgur.com/qS1ElRQ.png'
    },
    {
      'title': 'Laundry Services',
      'name': 'Phyllis Godley',
      'image': 'https://i.imgur.com/EkmfKk5.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: cancelledItems.length,
      itemBuilder: (context, index) {
        final item = cancelledItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        item['image']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['name']!,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Cancelled',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
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
              ),
              const Icon(Icons.keyboard_arrow_down, size: 28),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
