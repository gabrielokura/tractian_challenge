import 'package:tractian_challenge/domain/models/company_asset.dart';
import 'package:tractian_challenge/domain/models/location.dart';

import '../../../utils/result.dart';

abstract class AssetRepository {
  Future<Result<List<CompanyAsset>>> getAssetsFrom({required String companyId});
  Future<Result<List<Location>>> getLocationsFrom({required String companyId});
}
