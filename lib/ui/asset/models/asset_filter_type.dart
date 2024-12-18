import 'package:tractian_challenge/domain/models/tree_item.dart';

enum AssetFilterType { energy, critical, none }

class Filter {
  Filter({required this.query, required this.assetFilter});

  final AssetFilterType assetFilter;
  final String query;

  bool get isActive => assetFilter != AssetFilterType.none || query.isNotEmpty;

  bool isMatching(TreeItem item) {
    if (assetFilter == AssetFilterType.none && query.isEmpty) return true;

    if ((item.sensorType == SensorType.energy &&
            assetFilter == AssetFilterType.energy) ||
        (item.sensorType == SensorType.vibration &&
            assetFilter == AssetFilterType.critical)) {
      return true;
    }

    final nameContainsSearch =
        item.name.toLowerCase().contains(query.toLowerCase());
    if (query.isNotEmpty && nameContainsSearch) return true;

    return false;
  }
}
