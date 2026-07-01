import 'package:fpdart/fpdart.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/exception/app_failures.dart';

abstract interface class IAuthRepository {
  Future<Either<AppFailure, List<Country>>> getCountries({String? search});

  Future<Either<AppFailure, String>> sendOtp({
    required String countryCode,
    required String phoneNumber,
  });

  Future<Either<AppFailure, Map<String, dynamic>>> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otp,
  });

  Future<Either<AppFailure, void>> signOut();
}
