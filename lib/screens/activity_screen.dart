import 'dart:async';

import 'package:breatheclean_flutter/globals/pallete.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/activity_model.dart';
import '../models/channel_info_model.dart';
import '../models/data_model.dart';
import '../providers/webview_option_provider.dart';
import '../services/api_service.dart';
import '../widgets/activity_card.dart';
import '../providers/bottom_navigation_provider.dart';
import '../widgets/channel_selector.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late Future<ActivityData> futureData;
  late Future<ChannelInfoModel> futureChannelInfo;
  String appbarText = "Activities";
  String createdAt = "";
  double aqi = 0;
  int _selectedChannel = 2072987;
  List<DataModel> _data = [];
  ChannelInfoModel? _channelInfo;
  Map<String, String>? _chartUrls;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<ActivityData> fetchData() async {
    var channelInfo = await ApiService().fetchChannelInfo(_selectedChannel);
    setState(() {
      _channelInfo = channelInfo;
    });

    var chartUrls = await ApiService().fetchChartUrls(_selectedChannel, channelInfo);
    setState(() {
      _chartUrls = chartUrls;
    });

    var data = await ApiService().fetchData(_selectedChannel);
    DateTime dateTime = DateTime.parse(data.createdAt);
    String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

    String aqiFieldName = channelInfo.fields.entries.firstWhere((entry) => entry.value == 'Air Quality Index').key;
    String? aqiValue = data.data[aqiFieldName];
    double airQualityIndex = double.tryParse(aqiValue ?? '0') ?? 0.0;
    setState(() {
      createdAt = time;
      aqi = airQualityIndex;
      _data = data.data.entries.where((entry) => entry.value.isNotEmpty && entry.value != 'nan' && entry.value != 'inf').map((entry) => DataModel.fromActivityData(_channelInfo!, entry.key, entry.value, _chartUrls!)).toList();
    });
    return data;
  }

  Future<void> refreshData() async {
    var data = await fetchData();
    setState(() {
      futureData = Future.value(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: ChannelSelector(
          initialChannel: _selectedChannel,
          createdAt: createdAt,
          onChannelSelected: (channel) {
            setState(() {
              _selectedChannel = channel;
              futureData = fetchData();
            });
          },
        ),
        actions: [
          Consumer<WebViewOptionProvider>(
            builder: (context, webViewOptionProvider, child) {
              return Container(
                margin: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  child: Switch(
                    value: webViewOptionProvider.isChartEnabled,
                    onChanged: (value) {
                      webViewOptionProvider.toggle();
                      SnackBar snackBar = SnackBar(
                        content: Text("Chart option ${value ? 'enabled' : 'disabled'}"),
                        duration: const Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ),
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
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: ActivityCard(
                      icon: _data[index].icon,
                      name: _data[index].name,
                      value: _data[index].value!,
                      onTap: () {
                        bool isChartEnabled = Provider.of<WebViewOptionProvider>(context, listen: false).isChartEnabled;
                        if (isChartEnabled) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                                child: SizedBox(
                                  height: deviceHeight * 0.6,
                                  width: 300,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0), // adjust the radius as needed
                                    child: WebViewWidget(
                                      controller: WebViewController()
                                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                        ..setBackgroundColor(Colors.transparent)
                                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                        ..loadRequest(Uri.parse(_data[index].chartUrl!)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  );
                },
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
                    return Dialog(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SfRadialGauge(
                              axes: <RadialAxis>[
                                RadialAxis(
                                  minimum: 0,
                                  maximum: 200,
                                  ranges: <GaugeRange>[
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: 50,
                                      color: Pallete.goodValueColor,
                                    ),
                                    GaugeRange(
                                      startValue: 50,
                                      endValue: 100,
                                      color: Pallete.moderateValueColor,
                                    ),
                                    GaugeRange(
                                      startValue: 100,
                                      endValue: 150,
                                      color: Pallete.poorValueColor,
                                    ),
                                    GaugeRange(
                                      startValue: 150,
                                      endValue: 200,
                                      color: Pallete.extremePoorValueColor,
                                    ),
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
                          ],
                        ),
                      ),
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
