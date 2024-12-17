import 'dart:isolate';

import 'package:get/get.dart';
import 'package:tractian_challenge/domain/models/tree_item.dart';
import 'package:tractian_challenge/domain/use_cases/three_item/three_items_get_usecase.dart';
import 'package:tractian_challenge/ui/asset/models/asset_filter_type.dart';

import '../../../domain/models/company.dart';
import '../../../utils/state.dart';

class AssetViewModel {
  AssetViewModel({required ThreeItemsGetUsecase threeItemsGetUsecase})
      : _threeItemsGetUsecase = threeItemsGetUsecase;

  final ThreeItemsGetUsecase _threeItemsGetUsecase;

  final state = PageState.loading.obs;
  var _allItems = <TreeItem>[];

  final items = <TreeItem>[].obs;

  var filter = AssetFilterType.none.obs;

  void load(Company company) async {
    state.value = PageState.loading;

    final result = await _threeItemsGetUsecase.from(company);
    _allItems = result;

    items.value = await sort(result);

    state.value = PageState.success;
  }

  // void removeFilters() async {
  //   final rootItems = await sortItems();
  //   items.value = rootItems;
  // }

  void onTapFilter(AssetFilterType tapped) {
    if (filter.value == tapped) {
      filter.value = AssetFilterType.none;
      return;
    }

    filter.value = tapped;
  }

  void onTapItem(TreeItem item) async {
    if (item.hasChild == false) return;

    item.changeExpanded();
    final index = _allItems.indexWhere((current) => item.id == current.id);
    _allItems[index] = item;

    List<TreeItem> copy = [];
    copy.addAll(_allItems);

    items.value = await sort(copy);
  }

  Future<List<TreeItem>> sort(List<TreeItem> items) async {
    final result =
        await Isolate.run<List<TreeItem>>(() => items.toTreeHierarchy());
    return result;
  }
}

// Links: https://stackoverflow.com/questions/41347416/building-tree-view-algorithm
extension Sorting on List<TreeItem> {
  List<TreeItem> toTreeHierarchy() {
    Map<String?, List<TreeItem>> parentTree = {};
    List<TreeItem> selectedItems = [];

    for (var item in this) {
      parentTree.putIfAbsent(item.parentId, () => []).add(item);
    }

    buildHierarchy(map: parentTree, level: 0, selectedItems: selectedItems);

    return selectedItems;
  }

  void buildHierarchy({
    String? key,
    required Map<String?, List<TreeItem>> map,
    required int level,
    required List<TreeItem> selectedItems,
  }) {
    final children = map[key] ?? [];
    if (children.isEmpty) return;

    for (var child in children) {
      child.depth = level;
      child.hasChild = map.containsKey(child.id);
      selectedItems.add(child);

      if (child.isExpanded == false) continue;

      buildHierarchy(
          key: child.id,
          map: map,
          level: level + 1,
          selectedItems: selectedItems);
    }
  }
}
