import 'package:tractian_challenge/domain/models/three_item.dart';

class Location {
  final String id;
  final String name;
  final String? parentId;

  Location({required this.id, required this.name, this.parentId});
}

extension LocationToItem on List<Location> {
  List<ThreeItem> toThreeItem() {
    return map((location) => ThreeItem.fromLocation(location)).toList();
  }
}
