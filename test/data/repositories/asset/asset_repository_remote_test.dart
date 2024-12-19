import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/data/repositories/asset/asset_repository_remote.dart';
import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';
import 'package:tractian_challenge/utils/result.dart';

import '../../../helper/mocks.dart';
import '../../../helper/models_stubs.dart';

void main() {
  group('Asset remote repository tests', () {
    test('Given getAssets, when API succeeds it should returns ok result',
        () async {
      // Given
      final mockApiClient = MockApiClient();
      final sut = AssetRepositoryRemote(apiClient: mockApiClient);

      when(() => mockApiClient.getAssetsOf(companyId: any(named: 'companyId')))
          .thenAnswer((_) async => Result.ok([kAssetApiModel]));

      // When
      final result = await sut.getAssetsFrom(companyId: '123');

      // Then
      expect(result is Ok<List<CompanyAsset>>, isTrue);
      expect((result as Ok<List<CompanyAsset>>).value, isNotEmpty);
    });

    test('Given getAssets, when API succeeds it should returns error result',
        () async {
      // Given
      final mockApiClient = MockApiClient();
      final sut = AssetRepositoryRemote(apiClient: mockApiClient);

      when(() => mockApiClient.getAssetsOf(companyId: any(named: 'companyId')))
          .thenAnswer((_) async => Result.error(Exception()));

      // When
      final result = await sut.getAssetsFrom(companyId: '123');

      // Then
      expect(result is Error<List<CompanyAsset>>, isTrue);
    });

    test('Given getLocations, when API succeeds it should returns ok result',
        () async {
      // Given
      final mockApiClient = MockApiClient();
      final sut = AssetRepositoryRemote(apiClient: mockApiClient);

      when(() =>
              mockApiClient.getLocationsOf(companyId: any(named: 'companyId')))
          .thenAnswer((_) async => Result.ok([kLocationApiModel]));

      // When
      final result = await sut.getLocationsFrom(companyId: '123');

      // Then
      expect(result is Ok<List<Location>>, isTrue);
      expect((result as Ok<List<Location>>).value, isNotEmpty);
    });

    test('Given getLocations, when API succeeds it should returns error result',
        () async {
      // Given
      final mockApiClient = MockApiClient();
      final sut = AssetRepositoryRemote(apiClient: mockApiClient);

      when(() =>
              mockApiClient.getLocationsOf(companyId: any(named: 'companyId')))
          .thenAnswer((_) async => Result.error(Exception()));

      // When
      final result = await sut.getLocationsFrom(companyId: '123');

      // Then
      expect(result is Error<List<Location>>, isTrue);
    });
  });
}
