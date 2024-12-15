import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';

class ThreeItem {
  final ThreeItemType type;
  final String name;
  final String id;
  final String? parentId;
  final int depth;

  bool isExpanded = false;
  bool isRoot;

  ThreeItem(
      {required this.id,
      required this.name,
      this.parentId,
      required this.depth,
      required this.type,
      required this.isRoot});

  factory ThreeItem.fromAsset(CompanyAsset asset) {
    return ThreeItem(
        id: asset.id,
        parentId: asset.parentId ?? asset.locationId,
        name: asset.name,
        depth: 0,
        type: ThreeItemType.asset,
        isRoot: false);
  }

  factory ThreeItem.fromLocation(Location location) {
    return ThreeItem(
        id: location.id,
        name: location.name,
        parentId: location.parentId,
        depth: 0,
        type: ThreeItemType.location,
        isRoot: false);
  }
}

enum ThreeItemType { component, asset, location }
