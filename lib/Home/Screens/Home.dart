import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import '../../Common/BottomSheet.dart';
import '../bloc/AllServiceEvent.dart';
import '../bloc/AllServiceManBloc.dart';
import '../bloc/AllServiceManState.dart';
import '../bloc/HomeUserDetailBloc.dart';
import '../bloc/HomeUserDetailState.dart';
import '../bloc/homeuserevent.dart';
import '../repositry/AllServicemanRepository.dart';
import '../repositry/HomeUserDetailRepo.dart';
import '../models/AllServicemanModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeUserDetailBloc _userBloc;
  late AllServicemanBloc _servicemanBloc;
  String address = "";

  @override
  void initState() {
    super.initState();
    final box = Hive.box('userBox');
    final userId = box.get('userId');
    address = box.get('address') ?? "";

    _userBloc = HomeUserDetailBloc(HomeUserDetailRepository());
    _servicemanBloc = AllServicemanBloc(AllServicemanRepository());

    if (userId != null) {
      _userBloc.add(FetchUserDetail(userId));
    }

    if (address.isNotEmpty) {
      _servicemanBloc.add(FetchAllServicemanByLocation(address));
    }
  }

  @override
  void dispose() {
    _userBloc.close();
    _servicemanBloc.close();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _userBloc),
        BlocProvider.value(value: _servicemanBloc),
      ],
      child: BlocBuilder<HomeUserDetailBloc, HomeUserDetailState>(
        builder: (context, state) {
          String userName = "Loading...";
          String imageUrl = "";

          if (state is UserDetailLoaded) {
            userName = state.userDetail.name;
            imageUrl = state.userDetail.imageUrl;
            address = state.userDetail.address;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: imageUrl.isNotEmpty
                                  ? NetworkImage(imageUrl)
                                  : const NetworkImage("https://randomuser.me/api/portraits/men/75.jpg"),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Welcome 👋', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                Text(userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(icon: const Icon(FontAwesomeIcons.locationPin), onPressed: () {}),
                            Text(address, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
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

                  // Popular Services Section
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
                                labelStyle: TextStyle(color: index == 0 ? Colors.white : Colors.deepPurple),
                                backgroundColor: index == 0 ? Colors.deepPurple : Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        BlocBuilder<AllServicemanBloc, AllServicemanState>(
                          builder: (context, state) {
                            if (state is AllServicemanLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is AllServicemanLoaded) {
                              final servicemen = state.servicemen;
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: servicemen.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 16),
                                itemBuilder: (context, index) {
                                  final item = servicemen[index];
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 3))],
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Image.network(
                                            item.imageUrl,
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
                                              Text(item.name, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                                              const SizedBox(height: 4),
                                              Text(item.serviceHead, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 6),
                                              Text("Rs ${item.price}", style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                                              const SizedBox(height: 4),
                                              Text(item.category, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
                              );
                            } else if (state is AllServicemanError) {
                              return Text("Error: ${state.error}", style: const TextStyle(color: Colors.red));
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigation(currentIndex: 0),
          );
        },
      ),
    );
  }
}
