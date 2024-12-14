abstract class ThreeItem {
  final ThreeItemType type;
  final String name;
  final int depth;

  bool get isExpanded;

  ThreeItem({required this.name, required this.depth, required this.type});
}

enum ThreeItemType { component, asset, location }
