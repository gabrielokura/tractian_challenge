import 'package:get/get.dart';
import 'package:tractian_challenge/data/repositories/company/company_repository.dart';
import 'package:tractian_challenge/data/repositories/company/company_repository_remote.dart';
import 'package:tractian_challenge/data/services/api/api_client.dart';
import 'package:tractian_challenge/ui/home/view_models/home_viewmodel.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ApiClient>(ApiClient());
    Get.lazyPut<CompanyRepository>(
        () => CompanyRepositoryRemote(apiClient: Get.find()));

    // UI
    Get.put(HomeViewModel(companyRepository: Get.find()));
  }
}
