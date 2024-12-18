import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';

class TreeItem {
  TreeItem({
    required this.id,
    required this.name,
    this.parentId,
    required this.depth,
    required this.type,
    this.sensorType,
  });

  final TreeItemType type;
  final String name;
  final String id;
  final String? parentId;
  int depth;
  final SensorType? sensorType;

  bool hasChild = false;
  bool isExpanded = false;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! TreeItem) return false;

    return other.id == id && other.name == name;
  }

  void changeExpanded() {
    isExpanded = !isExpanded;
  }

  factory TreeItem.fromAsset(CompanyAsset asset) {
    try {
      final component = Component.fromCompanyAsset(asset);

      return TreeItem(
        id: component.id,
        parentId: component.parentId ?? component.locationId,
        name: component.name,
        depth: 0,
        type: TreeItemType.component,
        sensorType: component.sensorType == 'energy'
            ? SensorType.energy
            : SensorType.vibration,
      );
    } catch (error) {
      return TreeItem(
        id: asset.id,
        parentId: asset.parentId ?? asset.locationId,
        name: asset.name,
        depth: 0,
        type: TreeItemType.asset,
      );
    }
  }

  factory TreeItem.fromLocation(Location location) {
    return TreeItem(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      depth: 0,
      type: TreeItemType.location,
    );
  }
}

enum TreeItemType { component, asset, location }

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
      id: asset.id,
      parentId: asset.parentId,
      locationId: asset.locationId,
      name: asset.name,
      sensorType: asset.sensorType!,
    );
  }
}
