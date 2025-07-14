import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hamo/Services/Screens/AppliancaceServiceScreen.dart';
import 'package:hamo/Services/Screens/BeautyServiceScreen.dart';
import 'package:hamo/Services/Screens/LaundryServiceScreen.dart';
import 'package:hamo/Services/Screens/PaintingServiceScreen.dart';
import 'package:hamo/Services/Screens/PlumbingServiceScreen.dart';
import 'package:hamo/Services/Screens/ReparingServiceScreen.dart';
import 'package:hamo/Services/Screens/ShiftingServiceScreen.dart';
import 'package:hamo/Services/Screens/VechileReparingServiceScreen.dart';

import 'CleaningServiceScreen.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allServices = [
      {
        'icon': FontAwesomeIcons.broom,
        'label': 'Cleaning',
        'color': Colors.purple,
        'screen': CleaningServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.screwdriverWrench,
        'label': 'Repairing',
        'color': Colors.orange,
        'screen': ReparingServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.paintRoller,
        'label': 'Painting',
        'color': Colors.lightBlue,
        'screen': PaintingServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.shirt,
        'label': 'Laundry',
        'color': Colors.amber,
        'screen': LaundryServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.plug,
        'label': 'Appliance',
        'color': Colors.redAccent,
        'screen': AppliancesServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.wrench,
        'label': 'Plumbing',
        'color': Colors.green,
        'screen': PlumbingServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.truck,
        'label': 'Shifting',
        'color': Colors.lightBlueAccent,
        'screen': ShiftingServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.wandMagic,
        'label': 'Beauty',
        'color': Colors.purple,
        'screen': BeautyServiceListScreen(),
      },
      {
        'icon': FontAwesomeIcons.car,
        'label': 'Vehicle',
        'color': Colors.blue,
        'screen': VechileServiceListScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('All Services', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
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
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => service['screen']),
                );
              },
              child: Column(
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
              ),
            );
          },
        ),
      ),
    );
  }
}
