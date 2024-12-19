import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/domain/models/tree_item.dart';
import 'package:tractian_challenge/domain/use_cases/tree_item/tree_items_get_usecase.dart';
import 'package:tractian_challenge/ui/asset/models/filter.dart';

import '../../../domain/models/company.dart';
import '../../../utils/state.dart';

class AssetViewModel {
  AssetViewModel({required TreeItemsGetUsecase threeItemsGetUsecase})
      : _threeItemsGetUsecase = threeItemsGetUsecase;

  final TreeItemsGetUsecase _threeItemsGetUsecase;

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

    items.value = await buildTree(result, filter);

    state.value = PageState.success;
  }

  void onTapFilter(AssetFilterType tapped) async {
    if (assetFilter.value == tapped) {
      assetFilter.value = AssetFilterType.none;
    } else {
      assetFilter.value = tapped;
    }

    items.value = await buildTree(_allItems, filter);
  }

  void onTypeQuery(String text) async {
    searchQuery.value = text;

    items.value = await buildTree(_allItems, filter);
  }

  void onTapItem(TreeItem item) async {
    if (item.hasChild == false) return;

    item.changeExpanded();
    final index = _allItems.indexWhere((current) => item.id == current.id);
    _allItems[index] = item;

    items.value = await buildTree(_allItems, filter);
  }

  Future<List<TreeItem>> buildTree(List<TreeItem> items, Filter filter) async {
    return await compute(items.toTreeHierarchy, filter);
  }
}

extension BuildTree on List<TreeItem> {
  List<TreeItem> toTreeHierarchy(Filter filter) {
    Map<String?, List<TreeItem>> parentTree = {};
    List<TreeItem> selectedItems = [];
    Set<String> filteredItemsIds = {};

    for (var item in this) {
      parentTree.putIfAbsent(item.parentId, () => []).add(item);

      final isMatchingFilter = filter.isMatching(item);

      if (isMatchingFilter) {
        filteredItemsIds.add(item.id);

        if (filter.query.isNotEmpty) {
          final childrenIds =
              parentTree[item.id]?.map((item) => item.id).toList();

          filteredItemsIds.addAll(childrenIds ?? []);
        }

        String? currentParentId = item.parentId;
        while (currentParentId != null) {
          filteredItemsIds.add(currentParentId);
          currentParentId = firstWhere((i) => i.id == currentParentId).parentId;
        }
      }
    }

    _buildHierarchy(
        map: parentTree,
        level: 0,
        selectedItems: selectedItems,
        filter: filter,
        filteredItemsIds: filteredItemsIds);

    return selectedItems;
  }

  void _buildHierarchy({
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
      if (filter.isActive) {
        var isIncluded = filteredItemsIds.contains(child.id);

        if (isIncluded) {
          _addToTree(
            item: child,
            map: map,
            level: level,
            selectedItems: selectedItems,
            filter: filter,
            filteredItemsIds: filteredItemsIds,
          );
        }

        continue;
      }

      _addToTree(
        item: child,
        map: map,
        level: level,
        selectedItems: selectedItems,
        filter: filter,
        filteredItemsIds: filteredItemsIds,
      );
    }
  }

  void _addToTree({
    required TreeItem item,
    required Map<String?, List<TreeItem>> map,
    required int level,
    required List<TreeItem> selectedItems,
    required Filter filter,
    required Set<String> filteredItemsIds,
  }) {
    item.level = level;
    item.hasChild = map.containsKey(item.id);

    if (filter.isActive) item.isExpanded = true;

    selectedItems.add(item);

    if (item.isExpanded == false) return;

    _buildHierarchy(
      key: item.id,
      map: map,
      level: level + 1,
      selectedItems: selectedItems,
      filter: filter,
      filteredItemsIds: filteredItemsIds,
    );
  }
}
