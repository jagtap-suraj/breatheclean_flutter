import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/activity_model.dart';
import '../models/channel_info_model.dart';

class ApiService {
  final String _baseUrl = 'https://api.thingspeak.com/channels';
  final String _apiKey = 'YOUR_API_KEY';

  Future<ActivityData> fetchData(int channelNumber) async {
    final response = await http.get(Uri.parse('$_baseUrl/$channelNumber/feeds.json?api_key=$_apiKey&results=1'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['feeds'][0];
      return ActivityData.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ChannelInfoModel> fetchChannelInfo(int channelNumber) async {
    final response = await http.get(Uri.parse('$_baseUrl/$channelNumber/fields/1.json?results=0&api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ChannelInfoModel.fromJson(data);
    } else {
      throw Exception('Failed to load channel information');
    }
  }

  Future<Map<String, String>> fetchChartUrls(int channelNumber, ChannelInfoModel channelInfo) async {
    final Map<String, String> chartUrls = {};

    for (final entry in channelInfo.fields.entries) {
      final fieldNumber = entry.key.replaceAll('field', '');
      final fieldName = entry.value;
      final chartUrl = 'https://thingspeak.com/channels/$channelNumber/charts/$fieldNumber';
      chartUrls[fieldName] = chartUrl;
    }

    return chartUrls;
  }
}
