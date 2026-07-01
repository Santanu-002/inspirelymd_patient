// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CountryModel _$CountryModelFromJson(Map<String, dynamic> json) =>
    _CountryModel(
      countryCode: json['countryCode'] as String,
      countryName: json['countryName'] as String,
      isoCode: json['isoCode'] as String,
      digitCount: (json['digitCount'] as num).toInt(),
      flag: json['flag'] as String,
      timezone: json['timezone'] as String,
    );

Map<String, dynamic> _$CountryModelToJson(_CountryModel instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'countryName': instance.countryName,
      'isoCode': instance.isoCode,
      'digitCount': instance.digitCount,
      'flag': instance.flag,
      'timezone': instance.timezone,
    };
