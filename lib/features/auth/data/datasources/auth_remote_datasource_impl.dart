import 'package:dio/dio.dart';
import 'package:inspirelymd_patient/core/common/mixins/base_remote_data_source_mixin.dart';
import 'package:inspirelymd_patient/core/common/models/api_response/api_response.dart';
import 'package:inspirelymd_patient/core/common/models/country/country_model.dart';
import 'package:inspirelymd_patient/core/network/api/api_endpoints.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/i_auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl with BaseRemoteDataSource implements IAuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<ApiResponse<List<CountryModel>>> getCountries({String? search}) {
    return performApiRequest(
      _dio.get(
        ApiEndpoints.common.countries,
        queryParameters: search != null ? {'search': search} : null,
      ),
      (json) {
        final list = json as List<dynamic>;
        return list
            .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }

  @override
  Future<ApiResponse<String>> sendOtp({
    required String countryCode,
    required String phoneNumber,
  }) async {
    return performApiRequest(
      _dio.post(
        ApiEndpoints.auth.sendOtp,
        data: {
          'countryCode': countryCode,
          'phoneNumber': phoneNumber,
        },
      ),
      (json) {
        final map = json as Map<String, dynamic>;
        return map['otp'] as String;
      },
    );
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otp,
  }) async {
    return performApiRequest(
      _dio.post(
        ApiEndpoints.auth.verifyOtp,
        data: {
          'countryCode': countryCode,
          'phoneNumber': phoneNumber,
          'otp': otp,
        },
      ),
      (json) => json as Map<String, dynamic>,
    );
  }
}
