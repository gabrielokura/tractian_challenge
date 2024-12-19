class AssetApiModel {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  AssetApiModel({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
  });

  factory AssetApiModel.fromJson(Map<String, Object?> json) {
    final id = json['id'] as String;
    final name = json['name'] as String;
    final parentId = json['parentId'] as String?;
    final sensorId = json['sensorId'] as String?;
    final sensorType = json['sensorType'] as String?;
    final status = json['status'] as String?;
    final gatewayId = json['gatewayId'] as String?;
    final locationId = json['locationId'] as String?;

    return AssetApiModel(
      id: id,
      name: name,
      parentId: parentId,
      sensorId: sensorId,
      sensorType: sensorType,
      status: status,
      gatewayId: gatewayId,
      locationId: locationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
      'gatewayId': gatewayId,
      'locationId': locationId,
    };
  }
}
