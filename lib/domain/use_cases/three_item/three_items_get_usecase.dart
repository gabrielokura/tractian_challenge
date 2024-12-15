import 'package:flutter/material.dart';
import 'package:tractian_challenge/data/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/domain/models/three_item.dart';
import 'package:tractian_challenge/utils/result.dart';

class ThreeItemsGetUsecase {
  ThreeItemsGetUsecase({required AssetRepository assetRepository})
      : _assetRepository = assetRepository;

  final AssetRepository _assetRepository;

  Future<List<ThreeItem>> from(Company company) async {
    final (assetsResult, locationsResult) = await (
      _assetRepository.getAssetsFrom(companyId: company.id),
      _assetRepository.getLocationsFrom(companyId: company.id),
    ).wait;

    if (locationsResult is! Ok<List<Location>>) {
      debugPrint('Erro ao buscar locations');
      return [];
    }

    if (assetsResult is! Ok<List<CompanyAsset>>) {
      debugPrint('Erro ao buscar locations');
      return [];
    }

    var items = [
      ...locationsResult.value.toThreeItem(),
      ...assetsResult.value.toThreeItem()
    ];
    return items;
  }
}
