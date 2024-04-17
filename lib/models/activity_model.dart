class ActivityData {
  final String createdAt;
  final String temperature;
  final String humidity;
  final String lpg;
  final String carbonMonoxide;
  final String nitrogenOxide;
  final String airQualityIndex;
  final String pollutionRate;

  ActivityData({
    required this.createdAt,
    required this.temperature,
    required this.humidity,
    required this.lpg,
    required this.carbonMonoxide,
    required this.nitrogenOxide,
    required this.airQualityIndex,
    required this.pollutionRate,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    return ActivityData(
      createdAt: json['created_at'],
      temperature: json['field1'],
      humidity: json['field2'],
      lpg: json['field3'],
      carbonMonoxide: json['field4'],
      nitrogenOxide: json['field5'],
      airQualityIndex: json['field6'],
      pollutionRate: json['field7'],
    );
  }
}
