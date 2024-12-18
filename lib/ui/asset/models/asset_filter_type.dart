import 'package:tractian_challenge/domain/models/tree_item.dart';

enum AssetFilterType { energy, critical, none }

class Filter {
  Filter({required this.query, required this.assetFilter});

  final AssetFilterType assetFilter;
  final String query;

  bool get isActive => assetFilter != AssetFilterType.none || query.isNotEmpty;

  bool isMatching(TreeItem item) {
    bool isMatching = false;

    if (assetFilter != AssetFilterType.none) {
      final isSameSensorType = _isTheSame(item.sensorType, assetFilter);

      if (isSameSensorType == false) {
        return false;
      }

      isMatching = isSameSensorType;
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

  bool _isTheSame(SensorType? sensorType, AssetFilterType assetFilterType) {
    return (sensorType == SensorType.energy &&
            assetFilter == AssetFilterType.energy) ||
        (sensorType == SensorType.vibration &&
            assetFilter == AssetFilterType.critical);
  }
}
