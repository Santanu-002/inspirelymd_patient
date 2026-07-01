import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/i_auth_remote_datasource.dart';
import 'package:inspirelymd_patient/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:inspirelymd_patient/core/services/token/token_service.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final TokenService _tokenService;

  AuthRepositoryImpl(this._remoteDataSource, this._tokenService);

  @override
  Future<Either<AppFailure, List<Country>>> getCountries({
    String? search,
  }) async {
    try {
      final response = await _remoteDataSource.getCountries(search: search);
      if (response.success && response.data != null) {
        return right(response.data!);
      } else {
        return left(ServerFailure(response.message));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, String>> sendOtp({
    required String countryCode,
    required String phoneNumber,
  }) async {
    try {
      final response = await _remoteDataSource.sendOtp(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
      );
      if (response.success && response.data != null) {
        return right(response.data!);
      } else {
        return left(ServerFailure(response.message));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await _remoteDataSource.verifyOtp(
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        otp: otp,
      );
      if (response.success && response.data != null) {
        return right(response.data!);
      } else {
        return left(ServerFailure(response.message));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> signOut() async {
    try {
      await _tokenService.clearTokens();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
