import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CleaningServiceListScreen extends StatelessWidget {
  const CleaningServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cleaners = [
      {
        'name': 'Jenny Wilson',
        'title': 'House Cleaning',
        'price': 20,
        'rating': 4.8,
        'reviews': 4479,
        'image': 'https://images.unsplash.com/photo-1581578731548-c64695cc6950?auto=format&fit=crop&w=200&q=80'
      },
      {
        'name': 'Willard Purnell',
        'title': 'Floor Cleaning',
        'price': 23,
        'rating': 4.9,
        'reviews': 6182,
        'image': 'https://images.unsplash.com/photo-1581579185169-abc761a851d1?auto=format&fit=crop&w=200&q=80'
      },
      {
        'name': 'Tynisha Obey',
        'title': 'Washing Clothes',
        'price': 22,
        'rating': 4.7,
        'reviews': 7938,
        'image': 'https://images.unsplash.com/photo-1617137968423-c7b11c25ed0d?auto=format&fit=crop&w=200&q=80'
      },
      {
        'name': 'Georgette Strobel',
        'title': 'Bathroom Cleaning',
        'price': 24,
        'rating': 4.9,
        'reviews': 6182,
        'image': 'https://images.unsplash.com/photo-1612731486351-95d85f8a7c95?auto=format&fit=crop&w=200&q=80'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Cleaning', style: TextStyle(color: Colors.black)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.black),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cleaners.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> item = cleaners[index]; // ✅ fixed
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  child: Image.network(
                    item['image']!,
                    width: 100,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                // Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['title']!,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${item['price']}',
                          style: const TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${item['rating']}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '|  ${item['reviews']} reviews',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // Bookmark Icon
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(FontAwesomeIcons.bookmark, size: 18, color: Colors.deepPurpleAccent),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}