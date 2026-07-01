import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';

part 'country_model.freezed.dart';
part 'country_model.g.dart';

@freezed
sealed class CountryModel with _$CountryModel implements Country {
  const factory CountryModel({
    required String countryCode,
    required String countryName,
    required String isoCode,
    required int digitCount,
    required String flag,
    required String timezone,
  }) = _CountryModel;

  // Private constructor allows adding custom methods and implementing Equatable getters
  const CountryModel._();

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  @override
  List<Object?> get props => [
    countryCode,
    countryName,
    isoCode,
    digitCount,
    flag,
    timezone,
  ];

  @override
  bool? get stringify => true;
}
