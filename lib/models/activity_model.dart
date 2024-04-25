class ActivityData {
  final String createdAt;
  final Map<String, String> data;

  ActivityData({
    required this.createdAt,
    required this.data,
  });

  factory ActivityData.fromJson(Map<String, dynamic> json) {
    final data = <String, String>{};
    json.forEach((key, value) {
      if (key != 'created_at' && key != 'entry_id') {
        data[key] = value?.toString() ?? '';
      }
    });

    return ActivityData(
      createdAt: json['created_at'] ?? '',
      data: data,
    );
  }
}
