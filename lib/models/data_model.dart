import 'package:flutter/material.dart';

import '../globals/constant_icons.dart';
import '../models/channel_info_model.dart';

class DataModel {
  final String name;
  final String? value;
  final IconData icon;
  final String? chartUrl;

  DataModel({
    required this.name,
    required this.value,
    required this.icon,
    required this.chartUrl,
  });

  factory DataModel.fromActivityData(
    ChannelInfoModel channelInfo,
    String fieldName,
    String fieldValue,
    Map<String, String> chartUrls,
  ) {
    final Map<String, IconData> fieldIconMap = {
      'Temperature': MyIcons.iconTemperature,
      'Humidity': MyIcons.iconHumidity,
      'LPG': MyIcons.iconLPG,
      'Carbon Monoxide': MyIcons.iconCarbonMonoxide,
      'Ammonia': MyIcons.iconAmmonia,
      'Air Quality Index': MyIcons.iconAirQualityIndex,
      'PM 2.5': MyIcons.iconPM2_5,
    };

    final name = channelInfo.fields[fieldName] ?? fieldName;
    final icon = fieldIconMap[name] ?? MyIcons.iconDefault;

    // Check if the fieldValue is "inf", "NaN", or if it can be parsed as a valid double value
    final value = (fieldValue == "inf" || fieldValue == "NaN" || double.tryParse(fieldValue) == null) ? null : fieldValue;

    final chartUrl = chartUrls[name];

    return DataModel(
      name: name,
      value: value,
      icon: icon,
      chartUrl: chartUrl,
    );
  }
}
