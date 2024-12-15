import 'package:get/get.dart';
import 'package:tractian_challenge/domain/models/three_item.dart';
import 'package:tractian_challenge/domain/use_cases/three_item/three_items_get_usecase.dart';

import '../../../domain/models/company.dart';
import '../../../utils/state.dart';

class AssetViewModel {
  AssetViewModel({required ThreeItemsGetUsecase threeItemsGetUsecase})
      : _threeItemsGetUsecase = threeItemsGetUsecase;

  final ThreeItemsGetUsecase _threeItemsGetUsecase;

  final state = PageState.loading.obs;
  final items = <ThreeItem>[].obs;

  void load(Company company) async {
    state.value = PageState.loading;

    final result = await _threeItemsGetUsecase.from(company);

    items.value = result;

    state.value = PageState.success;
  }
}
