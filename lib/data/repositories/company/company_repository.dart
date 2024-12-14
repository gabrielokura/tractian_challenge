import 'package:tractian_challenge/domain/models/company.dart';
import 'package:tractian_challenge/utils/result.dart';

abstract class CompanyRepository {
  Future<Result<List<Company>>> getCompanies();
}
