import 'dart:convert';
import 'dart:io';

import 'package:tractian_challenge/data/services/api/model/asset_api_model.dart';
import 'package:tractian_challenge/data/services/api/model/company_api_model.dart';
import 'package:tractian_challenge/data/services/api/model/location_api_model.dart';
import 'package:tractian_challenge/utils/result.dart';

class ApiClient {
  final String _host = 'fake-api.tractian.com';
  final int _port = 8080;
  final HttpClient _httpClient = HttpClient();

  ApiClient();

  Future<Result<List<CompanyApiModel>>> getCompanies() async {
    try {
      final request = await _httpClient.get(_host, _port, '/companies');
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;

        final companies =
            json.map((element) => CompanyApiModel.fromJson(element)).toList();
        return Result.ok(companies);
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      _httpClient.close();
    }
  }

  Future<Result<List<LocationApiModel>>> getLocationsOf(
      {required String companyId}) async {
    try {
      final request = await _httpClient.get(
          _host, _port, '/companies/$companyId/locations');
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;

        final locations =
            json.map((element) => LocationApiModel.fromJson(element)).toList();
        return Result.ok(locations);
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      _httpClient.close();
    }
  }

  Future<Result<List<AssetApiModel>>> getAssetsOf(
      {required String companyId}) async {
    try {
      final request =
          await _httpClient.get(_host, _port, '/companies/$companyId/assets');
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;

        final assets =
            json.map((element) => AssetApiModel.fromJson(element)).toList();
        return Result.ok(assets);
      } else {
        return const Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      _httpClient.close();
    }
  }
}
