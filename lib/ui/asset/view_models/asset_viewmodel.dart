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

  var assetFilter = AssetFilterType.none.obs;
  var searchQuery = ''.obs;

  Filter get filter =>
      Filter(query: searchQuery.value, assetFilter: assetFilter.value);

  void load(Company company) async {
    state.value = PageState.loading;

    final result = await _threeItemsGetUsecase.from(company);
    _allItems = result;

    items.value = await sort(result, filter);

    state.value = PageState.success;
  }

  void onTapFilter(AssetFilterType tapped) async {
    if (assetFilter.value == tapped) {
      assetFilter.value = AssetFilterType.none;
    } else {
      assetFilter.value = tapped;
    }

    items.value = await sort(_allItems, filter);
  }

  void onTapItem(TreeItem item) async {
    if (item.hasChild == false) return;

    item.changeExpanded();
    final index = _allItems.indexWhere((current) => item.id == current.id);
    _allItems[index] = item;

    items.value = await sort(_allItems, filter);
  }

  Future<List<TreeItem>> sort(List<TreeItem> items, Filter filter) async {
    final result =
        await Isolate.run<List<TreeItem>>(() => items.toTreeHierarchy(filter));
    return result;
  }
}

// Links: https://stackoverflow.com/questions/41347416/building-tree-view-algorithm
extension Sorting on List<TreeItem> {
  List<TreeItem> toTreeHierarchy(Filter filter) {
    Map<String?, List<TreeItem>> parentTree = {};
    List<TreeItem> selectedItems = [];
    Set<String> filteredItemIds = {};

    for (var item in this) {
      parentTree.putIfAbsent(item.parentId, () => []).add(item);

      final isMatchingFilter = filter.isMatching(item);

      if (isMatchingFilter) {
        filteredItemIds.add(item.id);

        String? currentParentId = item.parentId;
        while (currentParentId != null) {
          filteredItemIds.add(currentParentId);
          currentParentId = firstWhere((i) => i.id == currentParentId).parentId;
        }
      }
    }

    buildHierarchy(
        map: parentTree,
        level: 0,
        selectedItems: selectedItems,
        filter: filter,
        filteredItemsIds: filteredItemIds);

    return selectedItems;
  }

  void buildHierarchy({
    String? key,
    required Map<String?, List<TreeItem>> map,
    required int level,
    required List<TreeItem> selectedItems,
    required Filter filter,
    required Set<String> filteredItemsIds,
  }) {
    final children = map[key] ?? [];
    if (children.isEmpty) return;

    for (var child in children) {
      child.depth = level;
      child.hasChild = map.containsKey(child.id);

      if (filter.isActive == false) {
        selectedItems.add(child);

        if (child.isExpanded == false) continue;

        buildHierarchy(
          key: child.id,
          map: map,
          level: level + 1,
          selectedItems: selectedItems,
          filter: filter,
          filteredItemsIds: filteredItemsIds,
        );

        continue;
      }

      if (filteredItemsIds.contains(child.id) == false) {
        continue;
      }

      selectedItems.add(child);

      child.changeExpanded();

      buildHierarchy(
        key: child.id,
        map: map,
        level: level + 1,
        selectedItems: selectedItems,
        filter: filter,
        filteredItemsIds: filteredItemsIds,
      );
    }
  }
}
