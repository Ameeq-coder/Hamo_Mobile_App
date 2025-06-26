import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Common/BottomSheet.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': FontAwesomeIcons.broom, 'label': 'Cleaning', 'color': Colors.purpleAccent},
      {'icon': FontAwesomeIcons.screwdriverWrench, 'label': 'Repairing', 'color': Colors.orange},
      {'icon': FontAwesomeIcons.paintRoller, 'label': 'Painting', 'color': Colors.lightBlue},
      {'icon': FontAwesomeIcons.shirt, 'label': 'Laundry', 'color': Colors.amber},
      {'icon': FontAwesomeIcons.plug, 'label': 'Appliance', 'color': Colors.redAccent},
      {'icon': FontAwesomeIcons.wrench, 'label': 'Plumbing', 'color': Colors.green},
      {'icon': FontAwesomeIcons.truck, 'label': 'Shifting', 'color': Colors.lightBlueAccent},
      {'icon': FontAwesomeIcons.ellipsis, 'label': 'More', 'color': Colors.deepPurple},
    ];

    final filters = ["All", "Cleaning", "Repairing", "Painting", "Laundry"];

    final servicesman = [
      {
        "name": "Kylee Danford",
        "title": "House Cleaning",
        "price": 25,
        "rating": 4.8,
        "reviews": 8289,
        "image": "https://images.unsplash.com/photo-1581578731548-c64695cc6950?auto=format&fit=crop&w=200&q=80"
      },
      {
        "name": "Alfonzo Schuessler",
        "title": "Floor Cleaning",
        "price": 20,
        "rating": 4.9,
        "reviews": 6182,
        "image": "https://images.unsplash.com/photo-1581579185169-abc761a851d1?auto=format&fit=crop&w=200&q=80"
      },
      {
        "name": "Sanjuanita Ordonez",
        "title": "Washing Clothes",
        "price": 22,
        "rating": 4.7,
        "reviews": 7938,
        "image": "https://www.freepik.com/free-photo/man-cleaning-floor-with-mop-full-shot_28637805.htm"
      },
      {
        "name": "Freida Varnes",
        "title": "Bathroom Cleaning",
        "price": 24,
        "rating": 4.9,
        "reviews": 6182,
        "image": "https://images.unsplash.com/photo-1612731486351-95d85f8a7c95?auto=format&fit=crop&w=200&q=80"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/75.jpg'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Welcome 👋', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          Text('Andrew Ainsley', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Icon(FontAwesomeIcons.sliders, size: 16),
                  ),
                ),
              ),
            ),

            // Services Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('See All', style: TextStyle(fontSize: 14, color: Colors.deepPurple)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: services.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final item = services[index];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (item['color'] as Color).withOpacity(0.1),
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              item['icon'] as IconData,
                              color: item['color'] as Color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(item['label'] as String, style: const TextStyle(fontSize: 12)),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // Popular Services with filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Most Popular Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("See All", style: TextStyle(color: Colors.deepPurple)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Chip(
                          label: Text(filters[index]),
                          labelStyle:  TextStyle(color: index == 0 ? Colors.white:Colors.deepPurple),
                          backgroundColor: index == 0
                              ? Colors.deepPurple
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Services List (fixed to use servicesman)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: servicesman.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> item = servicesman[index]; // ✅ fixed
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 3)),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item['image']!,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                  const SizedBox(height: 4),
                                  Text(item['title']!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 6),
                                  Text("\$${item['price']}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star, size: 14, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text("${item['rating']}", style: const TextStyle(fontSize: 12)),
                                      const SizedBox(width: 4),
                                      Text("|  ${item['reviews']} reviews", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.bookmark_border, color: Colors.deepPurple),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentIndex: 0,),
    );
  }
}