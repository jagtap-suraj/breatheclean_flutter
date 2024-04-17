import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
  String createdAt = "";
  double aqi = 0;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<ActivityData> fetchData() async {
    var data = await ApiService().fetchData();
    DateTime dateTime = DateTime.parse(data.createdAt);
    String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    double airQualityIndex = double.parse(data.airQualityIndex);
    setState(() {
      createdAt = time;
      aqi = airQualityIndex; // Update the class-level aqi variable
    });
    return data;
  }

  Future<void> refreshData() async {
    var data = await fetchData();
    setState(() {
      futureData = Future.value(data);
      DateTime dateTime = DateTime.parse(data.createdAt);
      String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
      createdAt = time;
      double airQualityIndex = double.parse(data.airQualityIndex);
      aqi = airQualityIndex;
    });
  }

  String getLevel(String value) {
    double val = double.parse(value);
    if (val < 27) {
      return 'low';
    } else if (val < 66) {
      return 'moderate';
    } else {
      return 'high';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              appbarText,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            createdAt.isNotEmpty
                ? Text(
                    'Last Updated At: $createdAt',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            // show a dialog onpressed with the text "info not available"
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      height: 200,
                      child: const Text(
                        'Info not available',
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
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
                  ActivityCard(icon: Icons.thermostat, name: 'Temperature', value: snapshot.data!.temperature, level: getLevel(snapshot.data!.temperature)),
                  ActivityCard(icon: Icons.water, name: 'Humidity', value: snapshot.data!.humidity, level: getLevel(snapshot.data!.humidity)),
                  ActivityCard(icon: Icons.fire_extinguisher, name: 'LPG', value: snapshot.data!.lpg, level: getLevel(snapshot.data!.lpg)),
                  ActivityCard(icon: Icons.smoke_free, name: 'Carbon Monoxide', value: snapshot.data!.carbonMonoxide, level: getLevel(snapshot.data!.carbonMonoxide)),
                  ActivityCard(icon: Icons.cloud, name: 'Nitrogen Oxide', value: snapshot.data!.nitrogenOxide, level: getLevel(snapshot.data!.nitrogenOxide)),
                  ActivityCard(icon: Icons.air, name: 'Air Quality Index', value: snapshot.data!.airQualityIndex, level: getLevel(snapshot.data!.airQualityIndex)),
                  ActivityCard(icon: Icons.poll, name: 'Pollution Rate', value: snapshot.data!.pollutionRate, level: getLevel(snapshot.data!.pollutionRate)),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: aqi != 0
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Wrap(children: [
                        Dialog(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: 0,
                                maximum: 200,
                                ranges: <GaugeRange>[
                                  GaugeRange(startValue: 0, endValue: 68, color: Colors.green),
                                  GaugeRange(startValue: 68, endValue: 134, color: Colors.orange),
                                  GaugeRange(startValue: 134, endValue: 200, color: Colors.red),
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(
                                    value: aqi,
                                    enableAnimation: true,
                                    animationDuration: 1000,
                                    needleLength: 0.6,
                                    knobStyle: const KnobStyle(knobRadius: 0.09, sizeUnit: GaugeSizeUnit.factor),
                                  )
                                ],
                                annotations: <GaugeAnnotation>[
                                  const GaugeAnnotation(widget: Text('Air Quality Index'), angle: 90, positionFactor: 0.5),
                                  GaugeAnnotation(widget: Text(aqi.truncate().toString()), angle: 90, positionFactor: 0.62),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    );
                  },
                );
              },
              child: const Icon(Icons.speed),
            )
          : null,
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
