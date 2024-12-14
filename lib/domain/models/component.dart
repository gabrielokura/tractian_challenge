import 'package:tractian_challenge/domain/models/three_item.dart';

class Component implements ThreeItem {
  @override
  final int depth;

  @override
  bool get isExpanded => false;

  @override
  final String name;

  @override
  ThreeItemType get type => ThreeItemType.component;

  Component({required this.name, required this.depth});
}
