import 'package:tractian_challenge/data/services/api/api_client.dart';
import 'package:tractian_challenge/data/services/api/model/company_api_model.dart';
import 'package:tractian_challenge/domain/models/company.dart';

import 'package:tractian_challenge/utils/result.dart';

import 'company_repository.dart';

class CompanyRepositoryRemote implements CompanyRepository {
  CompanyRepositoryRemote({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<List<Company>>> getCompanies() async {
    final apiResult = await _apiClient.getCompanies();

    if (apiResult is Ok<List<CompanyApiModel>>) {
      final convertedResult = apiResult.value
          .map((model) => Company(id: model.id, name: model.name))
          .toList();

      return Result.ok(convertedResult);
    }

    if (apiResult is Error<List<CompanyApiModel>>) {
      return Result.error(apiResult.error);
    }

    return Result.error(Exception('Unknown API Error'));
  }
}
