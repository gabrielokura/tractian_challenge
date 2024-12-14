class LocationApiModel {
  final String id;
  final String name;
  final String? parentId;

  LocationApiModel({required this.id, required this.name, this.parentId});

  factory LocationApiModel.fromJson(Map<String, Object?> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final parentId = json['parentId'] as String?;

    return LocationApiModel(id: id, name: name, parentId: parentId);
  }
}
