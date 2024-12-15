import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';

import '../../../domain/models/company.dart';
import '../../../utils/result.dart';

abstract class AssetRepository {
  Future<Result<List<CompanyAsset>>> getAssetsFrom({required Company company});
  Future<Result<List<Location>>> getLocationsFrom({required Company company});
}
