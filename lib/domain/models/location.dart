import 'package:tractian_challenge/domain/models/tree_item.dart';

class Location {
  final String id;
  final String name;
  final String? parentId;

  Location({required this.id, required this.name, this.parentId});
}

extension LocationToItem on List<Location> {
  List<TreeItem> toThreeItem() {
    return map((location) => TreeItem.fromLocation(location)).toList();
  }
}
