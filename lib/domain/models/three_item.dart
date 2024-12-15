import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';

class ThreeItem {
  final ThreeItemType type;
  final String name;
  final String id;
  final String? parentId;
  final int depth;
  final String? sensorType;

  bool isExpanded = false;

  bool get hasIndicator => sensorType != null;

  ThreeItem({
    required this.id,
    required this.name,
    this.parentId,
    required this.depth,
    required this.type,
    this.sensorType,
  });

  factory ThreeItem.fromAsset(CompanyAsset asset) {
    try {
      final component = Component.fromCompanyAsset(asset);

      return ThreeItem(
        id: component.id,
        parentId: component.parentId ?? component.locationId,
        name: component.name,
        depth: 0,
        type: ThreeItemType.component,
        sensorType: component.sensorType,
      );
    } catch (error) {
      return ThreeItem(
        id: asset.id,
        parentId: asset.parentId ?? asset.locationId,
        name: asset.name,
        depth: 0,
        type: ThreeItemType.asset,
      );
    }
  }

  factory ThreeItem.fromLocation(Location location) {
    return ThreeItem(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      depth: 0,
      type: ThreeItemType.location,
    );
  }
}

enum ThreeItemType { component, asset, location }

enum SensorType { energy, vibration }

class Component {
  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final String sensorType;

  Component(
      {required this.id,
      required this.name,
      this.locationId,
      this.parentId,
      required this.sensorType});

  factory Component.fromCompanyAsset(CompanyAsset asset) {
    return Component(
        id: asset.id, name: asset.name, sensorType: asset.sensorType!);
  }
}
