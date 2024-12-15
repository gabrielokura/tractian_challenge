import 'package:get/get.dart';
import 'package:tractian_challenge/data/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/data/repositories/asset/asset_repository_remote.dart';
import 'package:tractian_challenge/domain/use_cases/three_item/three_items_get_usecase.dart';
import 'package:tractian_challenge/ui/asset/view_models/asset_viewmodel.dart';

import '../../../data/services/api/api_client.dart';

class AssetBinding implements Bindings {
  @override
  void dependencies() {
    // Services
    Get.put<ApiClient>(ApiClient());

    // Repositories
    Get.lazyPut<AssetRepository>(
        () => AssetRepositoryRemote(apiClient: Get.find()));

    // Usecases
    Get.put(ThreeItemsGetUsecase(assetRepository: Get.find()));

    // UI
    Get.put(AssetViewModel(threeItemsGetUsecase: Get.find()));
  }
}
