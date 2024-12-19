import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/data/services/api/api_client.dart';
import 'package:tractian_challenge/data/services/api/model/asset_api_model.dart';
import 'package:tractian_challenge/data/services/api/model/company_api_model.dart';
import 'package:tractian_challenge/data/services/api/model/location_api_model.dart';
import 'package:tractian_challenge/utils/result.dart';

import '../../helper/mocks.dart';

void main() {
  group('API Client tests', () {
    test('It should return all companies', () async {
      // Given
      final mockHttpClient = MockHttpClient();
      final sut = ApiClient(clientFactory: () => mockHttpClient);

      final companiesStub = [CompanyApiModel(id: '123', name: '123')];

      mockHttpClient.mockGet('/companies', companiesStub);

      // When
      final result = await sut.getCompanies();

      // Then
      expect(result is Ok<List<CompanyApiModel>>, isTrue);
    });

    test('It should return all assets from company', () async {
      // Given
      final mockHttpClient = MockHttpClient();
      final sut = ApiClient(clientFactory: () => mockHttpClient);

      final assetsStub = [AssetApiModel(id: '123', name: '123')];

      mockHttpClient.mockGet('/companies/123/assets', assetsStub);

      // When
      final result = await sut.getAssetsOf(companyId: '123');

      // Then
      expect(result is Ok<List<AssetApiModel>>, isTrue);
    });

    test('It should return all locations from company', () async {
      // Given
      final mockHttpClient = MockHttpClient();
      final sut = ApiClient(clientFactory: () => mockHttpClient);

      final assetsStub = [AssetApiModel(id: '123', name: '123')];

      mockHttpClient.mockGet('/companies/123/locations', assetsStub);

      // When
      final result = await sut.getLocationsOf(companyId: '123');

      // Then
      expect(result is Ok<List<LocationApiModel>>, isTrue);
    });
  });
}
