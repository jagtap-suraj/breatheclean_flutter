import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../globals/pallete.dart';
import '../models/activity_model.dart';
import '../services/api_service.dart';
import '../widgets/activity_card.dart';
import '../providers/bottom_navigation_provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late Future<ActivityData> futureData;
  String appbarText = "Activities";

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<ActivityData> fetchData() async {
    return await ApiService().fetchData();
  }

  Future<void> refreshData() async {
    setState(() {
      futureData = fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appbarText,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder<ActivityData>(
          future: Future.any([
            futureData,
            Future<ActivityData>.delayed(
              const Duration(seconds: 20),
              () => throw TimeoutException('Data not available'),
            ),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            } else {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: <Widget>[
                  ActivityCard(icon: Icons.thermostat, name: 'Temperature', value: snapshot.data!.temperature),
                  ActivityCard(icon: Icons.water, name: 'Humidity', value: snapshot.data!.humidity),
                  ActivityCard(icon: Icons.fire_extinguisher, name: 'LPG', value: snapshot.data!.lpg),
                  ActivityCard(icon: Icons.smoke_free, name: 'Carbon Monoxide', value: snapshot.data!.carbonMonoxide),
                  ActivityCard(icon: Icons.cloud, name: 'Nitrogen Oxide', value: snapshot.data!.nitrogenOxide),
                  ActivityCard(icon: Icons.air, name: 'Air Quality Index', value: snapshot.data!.airQualityIndex),
                  ActivityCard(icon: Icons.poll, name: 'Pollution Rate', value: snapshot.data!.pollutionRate),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavProvider>(
        builder: (context, bottomNavProvider, child) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.air),
                label: 'Activities',
              ),
            ],
            currentIndex: bottomNavProvider.currentIndex,
            selectedItemColor: Pallete.navigationButtonOn,
            onTap: (index) {
              bottomNavProvider.changeIndex(index);
              if (index == 0) {
                Navigator.pop(context);
              }
            },
          );
        },
      ),
    );
  }
}
