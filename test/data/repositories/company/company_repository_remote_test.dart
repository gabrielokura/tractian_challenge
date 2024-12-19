import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/data/repositories/company/company_repository_remote.dart';
import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/utils/result.dart';

import '../../../helper/mocks.dart';
import '../../../helper/models_stubs.dart';

void main() {
  group('Company remote repository tests', () {
    test('Given getCompanies, when API succeeds it should returns ok result',
        () async {
      // Given
      final mockApiClient = MockApiClient();
      final sut = CompanyRepositoryRemote(apiClient: mockApiClient);

      when(() => mockApiClient.getCompanies()).thenAnswer(
          (_) async => Result.ok([kCompanyApiModel, kCompanyApiModel]));

      // When
      final result = await sut.getCompanies();

      // Then
      expect(result is Ok<List<Company>>, isTrue);
      expect((result as Ok<List<Company>>).value, isNotEmpty);
    });

    test('Given getCompanies, when API succeeds it should returns error result',
        () async {
      // Given
      final mockApiClient = MockApiClient();
      final sut = CompanyRepositoryRemote(apiClient: mockApiClient);

      when(() => mockApiClient.getCompanies())
          .thenAnswer((_) async => Result.error(Exception()));

      // When
      final result = await sut.getCompanies();

      // Then
      expect(result is Error<List<Company>>, isTrue);
    });
  });
}
