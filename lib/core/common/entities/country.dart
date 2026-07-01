import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String countryCode;
  final String countryName;
  final String isoCode;
  final int digitCount;
  final String flag;
  final String timezone;

  const Country({
    required this.countryCode,
    required this.countryName,
    required this.isoCode,
    required this.digitCount,
    required this.flag,
    required this.timezone,
  });

  @override
  List<Object?> get props => [
        countryCode,
        countryName,
        isoCode,
        digitCount,
        flag,
        timezone,
      ];
}
