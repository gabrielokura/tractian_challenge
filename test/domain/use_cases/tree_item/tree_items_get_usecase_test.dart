import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/data/repositories/asset/asset_repository.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/domain/use_cases/tree_item/tree_items_get_usecase.dart';
import 'package:tractian_challenge/utils/result.dart';

import '../../../helper/models_stubs.dart';

void main() {
  group('TreeItemsGetUsecase tests', () {
    test(
        'Given a company, when repository succeeds it should return a non-empty list',
        () async {
      // Given
      final mockAssetRepository = MockAssetRepository();
      final sut = TreeItemsGetUsecase(assetRepository: mockAssetRepository);

      final dummyCompany = Company(id: '123', name: '123');

      // When
      final result = await sut.from(dummyCompany);

      // Then
      expect(result.isNotEmpty, isTrue);
    });
  });
}

class MockAssetRepository extends Mock implements AssetRepository {
  final List<CompanyAsset> assets = [kCompanyAsset1];
  final List<Location> locations = [kLocation1];

  @override
  Future<Result<List<CompanyAsset>>> getAssetsFrom(
      {required String companyId}) async {
    return Result.ok(assets);
  }

  @override
  Future<Result<List<Location>>> getLocationsFrom(
      {required String companyId}) async {
    return Result.ok(locations);
  }
}
