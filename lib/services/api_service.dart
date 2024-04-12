import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity_model.dart';

class ApiService {
  final String _url = 'https://api.thingspeak.com/channels/2072987/feeds/last.json';

  Future<ActivityData> fetchData() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      return ActivityData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
