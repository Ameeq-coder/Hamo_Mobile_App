import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final allServices = [
      {'icon': FontAwesomeIcons.broom, 'label': 'Cleaning', 'color': Colors.purple},
      {'icon': FontAwesomeIcons.screwdriverWrench, 'label': 'Repairing', 'color': Colors.orange},
      {'icon': FontAwesomeIcons.paintRoller, 'label': 'Painting', 'color': Colors.lightBlue},
      {'icon': FontAwesomeIcons.shirt, 'label': 'Laundry', 'color': Colors.amber},
      {'icon': FontAwesomeIcons.plug, 'label': 'Appliance', 'color': Colors.redAccent},
      {'icon': FontAwesomeIcons.wrench, 'label': 'Plumbing', 'color': Colors.green},
      {'icon': FontAwesomeIcons.truck, 'label': 'Shifting', 'color': Colors.lightBlueAccent},
      {'icon': FontAwesomeIcons.wandMagic, 'label': 'Beauty', 'color': Colors.purple},
      {'icon': FontAwesomeIcons.fan, 'label': 'AC Repa..', 'color': Colors.greenAccent},
      {'icon': FontAwesomeIcons.car, 'label': 'Vehicle', 'color': Colors.blue},
      {'icon': FontAwesomeIcons.tv, 'label': 'Electronics', 'color': Colors.orangeAccent},
      {'icon': FontAwesomeIcons.spa, 'label': 'Massage', 'color': Colors.pinkAccent},
      {'icon': FontAwesomeIcons.marsStroke, 'label': 'Men\'s Sal..', 'color': Colors.deepPurple},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('All Services', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: GridView.builder(
          itemCount: allServices.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final service = allServices[index];
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (service['color'] as Color).withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    service['icon'] as IconData,
                    color: service['color'] as Color,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  service['label'] as String,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
