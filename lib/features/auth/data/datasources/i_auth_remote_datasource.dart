import 'package:inspirelymd_patient/core/common/models/api_response/api_response.dart';
import 'package:inspirelymd_patient/core/common/models/country/country_model.dart';

abstract interface class IAuthRemoteDataSource {
  Future<ApiResponse<List<CountryModel>>> getCountries({String? search});

  Future<ApiResponse<String>> sendOtp({
    required String countryCode,
    required String phoneNumber,
  });

  Future<ApiResponse<Map<String, dynamic>>> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otp,
  });
}
