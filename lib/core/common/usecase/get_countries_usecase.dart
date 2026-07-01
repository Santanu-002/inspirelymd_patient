import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/common/usecase/usecase.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';

class GetCountriesUseCase implements BaseUseCase<List<Country>, GetCountriesParams> {
  final IAuthRepository _repository;

  GetCountriesUseCase(this._repository);

  @override
  Future<Either<AppFailure, List<Country>>> call(GetCountriesParams params) {
    return _repository.getCountries(search: params.search);
  }
}

class GetCountriesParams {
  final String? search;

  const GetCountriesParams({this.search});
}
