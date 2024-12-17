import 'dart:isolate';

import 'package:get/get.dart';
import 'package:tractian_challenge/domain/models/tree_item.dart';
import 'package:tractian_challenge/domain/use_cases/three_item/three_items_get_usecase.dart';

import '../../../domain/models/company.dart';
import '../../../utils/state.dart';

class AssetViewModel {
  AssetViewModel({required ThreeItemsGetUsecase threeItemsGetUsecase})
      : _threeItemsGetUsecase = threeItemsGetUsecase;

  final ThreeItemsGetUsecase _threeItemsGetUsecase;

  final state = PageState.loading.obs;
  var _allItems = <TreeItem>[];

  final items = <TreeItem>[].obs;

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

  void onTapItem(TreeItem item) async {
    if (item.children.isEmpty) return;

    item.changeExpanded();

    List<TreeItem> copy = [];
    copy.addAll(items);

    items.value = await sort(copy);
  }

  Future<List<TreeItem>> sort(List<TreeItem> items) async {
    final result =
        await Isolate.run<List<TreeItem>>(() => items.toSortedList());
    return result;
  }
}

extension Sorting on List<TreeItem> {
  List<TreeItem> toSortedList() {
    var sortedItems = this;

    sortedItems.sort((a, b) {
      if (a.parentId == null) {
        return -1;
      }

      if (b.parentId == null) {
        return 1;
      }

      return a.parentId!.compareTo(b.parentId!);
    });

    Map<String?, TreeItem> itemMap = {};

    for (var item in sortedItems) {
      itemMap.putIfAbsent(item.id, () => item);

      final parentHasChild =
          itemMap[item.parentId]?.children.isNotEmpty ?? false;

      if (parentHasChild == false) {
        itemMap[item.parentId]?.addChild(item);
      }
    }

    void addChildren(TreeItem item, List<TreeItem> items, int level) {
      if (item.isExpanded == false || item.children.isEmpty) return;

      for (var child in item.children) {
        item.depth = level;
        items.add(child);

        addChildren(child, items, level + 1);
      }
    }

    List<TreeItem> selectedItems = [];
    for (var entry in itemMap.entries) {
      if (entry.value.parentId != null) continue;

      entry.value.depth = 0;
      selectedItems.add(entry.value);

      addChildren(entry.value, selectedItems, 1);
    }

    return selectedItems;
  }
}
