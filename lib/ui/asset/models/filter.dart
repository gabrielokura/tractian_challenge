import 'package:tractian_challenge/domain/models/tree_item.dart';

enum AssetFilterType { energy, critical, none }

class Filter {
  Filter({required this.query, required this.assetFilter});

  final AssetFilterType assetFilter;
  final String query;

  bool get isActive => assetFilter != AssetFilterType.none || query.isNotEmpty;

  bool isMatching(TreeItem item) {
    bool isMatching = false;

    if (assetFilter == AssetFilterType.critical) {
      isMatching = item.sensorStatus == SensorStatus.alert;

      if (isMatching == false) return false;
    }

    if (assetFilter == AssetFilterType.energy) {
      isMatching = item.sensorType == SensorType.energy;

      if (isMatching == false) return false;
    }

    if (query.isNotEmpty) {
      final nameContainsSearch =
          item.name.toLowerCase().contains(query.toLowerCase());

      if (nameContainsSearch == false) {
        return false;
      }

      isMatching = nameContainsSearch;
    }

    return isMatching;
  }
}
