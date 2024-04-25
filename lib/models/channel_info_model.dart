class ChannelInfoModel {
  final int id;
  final String name;
  final Map<String, String> fields;

  ChannelInfoModel({
    required this.id,
    required this.name,
    required this.fields,
  });

  factory ChannelInfoModel.fromJson(Map<String, dynamic> json) {
    final fields = <String, String>{};
    json['channel'].forEach((key, value) {
      if (key.startsWith('field') && value != null) {
        fields[key] = value.toString();
      }
    });

    return ChannelInfoModel(
      id: json['channel']['id'],
      name: json['channel']['name'],
      fields: fields,
    );
  }
}
