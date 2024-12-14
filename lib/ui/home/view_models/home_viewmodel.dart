import 'package:get/get.dart';
import 'package:tractian_challenge/data/repositories/company/company_repository.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/utils/state.dart';

import '../../../utils/result.dart';

class HomeViewModel {
  HomeViewModel({required CompanyRepository companyRepository})
      : _companyRepository = companyRepository {
    _load();
  }

  final CompanyRepository _companyRepository;

  final state = PageState.loading.obs;
  final companies = <Company>[].obs;

  void _load() async {
    state.value = PageState.loading;

    final result = await _companyRepository.getCompanies();

    switch (result) {
      case Ok<List<Company>>():
        state.value = PageState.success;
        companies.value = result.value;
      case Error<List<Company>>():
        state.value = PageState.error;
    }
  }
}
