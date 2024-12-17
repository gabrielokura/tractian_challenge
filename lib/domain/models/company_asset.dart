import 'tree_item.dart';

class CompanyAsset {
  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  CompanyAsset({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
  });
}

extension CompanyAssetToItem on List<CompanyAsset> {
  List<TreeItem> toThreeItem() {
    return map((asset) => TreeItem.fromAsset(asset)).toList();
  }
}
