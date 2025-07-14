import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import '../../ServiceDetail/Bloc/ServiceManDetailBloc.dart';
import '../../ServiceDetail/Repositry/ServiceManDetailRepository.dart';
import '../../ServiceDetail/Screens/ServiceDetailScreen.dart';
import '../BLOC/FetchServicemenEvent.dart';
import '../BLOC/ServicemanBloc.dart';
import '../BLOC/ServicemanState.dart';
import '../Models/ServiceManModel.dart';
import '../Repositry/ServicemanRepository.dart';

class AppliancesServiceListScreen extends StatelessWidget {
  const AppliancesServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userId="";
    final locationBox = Hive.box('userBox');
    final location = locationBox.get('address') ?? "";
    const category = 'Electrician';
    final username=locationBox.get('username');

    userId = locationBox.get('userId');


    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Electrician', style: TextStyle(color: Colors.black)),
      ),
      body: BlocProvider(
        create: (context) => AllServicemenLocationAndCatBloc(AllServicemenLocationAndCatRepository())
          ..add(FetchAllServicemenLocationAndCat(category: category, location: location)),
        child: BlocBuilder<AllServicemenLocationAndCatBloc, AllServicemenLocationAndCatState>(
          builder: (context, state) {
            if (state is AllServicemenLocationAndCatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AllServicemenLocationAndCatLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.servicemen.length,
                itemBuilder: (context, index) {
                  final AllServicemenLocationAndCat item = state.servicemen[index];

                  return GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => ServiceDetailBloc(ServiceDetailRepository()),
                            child:  ServiceDetailScreen(serviceManId: item.servicemanId,
                              userId: userId,
                              username: username,
                            ),
                          ),
                        ),
                      );

                    },
                    child: Container(
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
                          // Service image
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: Image.network(
                              item.imageUrl.isNotEmpty
                                  ? item.imageUrl
                                  : 'https://via.placeholder.com/100x110.png?text=Image',
                              width: 100,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Service Info
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.serviceHead,
                                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${item.price} PKR',
                                    style: const TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is AllServicemenLocationAndCatError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}