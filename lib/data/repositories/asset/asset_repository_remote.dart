import 'package:tractian_challenge/data/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/data/services/api/model/asset_api_model.dart';
import 'package:tractian_challenge/data/services/api/model/location_api_model.dart';
import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/utils/result.dart';

import '../../services/api/api_client.dart';

class AssetRepositoryRemote implements AssetRepository {
  AssetRepositoryRemote({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<List<CompanyAsset>>> getAssetsFrom(
      {required String companyId}) async {
    final apiResult = await _apiClient.getAssetsOf(companyId: companyId);

    if (apiResult is Ok<List<AssetApiModel>>) {
      final convertedResult = apiResult.value
          .map((model) => CompanyAsset(
                id: model.id,
                name: model.name,
                locationId: model.locationId,
                parentId: model.parentId,
                sensorId: model.sensorId,
                sensorType: model.sensorType,
                status: model.status,
                gatewayId: model.gatewayId,
              ))
          .toList();

      return Result.ok(convertedResult);
    }

    if (apiResult is Error<List<AssetApiModel>>) {
      return Result.error(apiResult.error);
    }

    return Result.error(Exception('Unknown API Error'));
  }

  @override
  Future<Result<List<Location>>> getLocationsFrom(
      {required String companyId}) async {
    final apiResult = await _apiClient.getLocationsOf(companyId: companyId);

    if (apiResult is Ok<List<LocationApiModel>>) {
      final convertedResult = apiResult.value
          .map((model) => Location(
              id: model.id, name: model.name, parentId: model.parentId))
          .toList();

      return Result.ok(convertedResult);
    }

    if (apiResult is Error<List<LocationApiModel>>) {
      return Result.error(apiResult.error);
    }

    return Result.error(Exception('Unknown API Error'));
  }
}
