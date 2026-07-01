import 'dart:math';
import 'package:inspirelymd_patient/core/common/mixins/base_local_data_source_mixin.dart';
import 'package:inspirelymd_patient/core/common/models/api_response/api_response.dart';
import 'package:inspirelymd_patient/core/common/models/country/country_model.dart';
import 'package:inspirelymd_patient/core/services/database/database_service.dart';
import 'package:inspirelymd_patient/features/auth/data/datasources/i_auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl with BaseLocalDataSource implements IAuthRemoteDataSource {
  final DatabaseService _dbService;

  AuthRemoteDataSourceImpl(this._dbService);

  @override
  Future<ApiResponse<List<CountryModel>>> getCountries({String? search}) async {
    return performLocalRequest(() async {
      // Simulate small network delay to keep loading shimmers visible for design review
      await Future.delayed(const Duration(milliseconds: 600));
      return await _dbService.getCountriesList(search: search);
    });
  }

  @override
  Future<ApiResponse<String>> sendOtp({
    required String countryCode,
    required String phoneNumber,
  }) async {
    return performLocalRequest(() async {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Generate a dynamic random 6-digit OTP
      final random = Random();
      final otp = List.generate(6, (_) => random.nextInt(10).toString()).join();
      
      // Save code to local DB
      await _dbService.saveOtp(phoneNumber, otp);
      
      return otp;
    });
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> verifyOtp({
    required String countryCode,
    required String phoneNumber,
    required String otp,
  }) async {
    return performLocalRequest(() async {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Any OTP except "111111" is allowed
      if (otp == '111111') {
        throw AuthException('Invalid verification code.');
      }
      
      // Retrieve or create a local user in sqflite
      var user = await _dbService.getUser(phoneNumber, countryCode);
      if (user == null) {
        user = {
          'id': 'user-${DateTime.now().millisecondsSinceEpoch}',
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
          'name': 'Sarah Mitchell',
          'email': 'sarah.mitchell@gmail.com',
          'createdAt': DateTime.now().toIso8601String(),
        };
        await _dbService.saveUser(user);
      }
      
      return {
        'token': 'mock-jwt-token-from-sqlite',
        'refreshToken': 'mock-refresh-token-from-sqlite',
        'user': user,
      };
    });
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
