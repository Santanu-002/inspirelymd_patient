import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

const List<Country> defaultCountries = [
  Country(
    countryName: 'United States',
    countryCode: '+1',
    flag: '🇺🇸',
    isoCode: 'US',
    digitCount: 10,
    timezone: 'America/New_York',
  ),
  Country(
    countryName: 'India',
    countryCode: '+91',
    flag: '🇮🇳',
    isoCode: 'IN',
    digitCount: 10,
    timezone: 'Asia/Kolkata',
  ),
  Country(
    countryName: 'United Kingdom',
    countryCode: '+44',
    flag: '🇬🇧',
    isoCode: 'GB',
    digitCount: 10,
    timezone: 'Europe/London',
  ),
  Country(
    countryName: 'Canada',
    countryCode: '+1',
    flag: '🇨🇦',
    isoCode: 'CA',
    digitCount: 10,
    timezone: 'America/Toronto',
  ),
  Country(
    countryName: 'Australia',
    countryCode: '+61',
    flag: '🇦🇺',
    isoCode: 'AU',
    digitCount: 9,
    timezone: 'Australia/Sydney',
  ),
  Country(
    countryName: 'Germany',
    countryCode: '+49',
    flag: '🇩🇪',
    isoCode: 'DE',
    digitCount: 11,
    timezone: 'Europe/Berlin',
  ),
  Country(
    countryName: 'United Arab Emirates',
    countryCode: '+971',
    flag: '🇦🇪',
    isoCode: 'AE',
    digitCount: 9,
    timezone: 'Asia/Dubai',
  ),
  Country(
    countryName: 'Singapore',
    countryCode: '+65',
    flag: '🇸🇬',
    isoCode: 'SG',
    digitCount: 8,
    timezone: 'Asia/Singapore',
  ),
  Country(
    countryName: 'New Zealand',
    countryCode: '+64',
    flag: '🇳🇿',
    isoCode: 'NZ',
    digitCount: 9,
    timezone: 'Pacific/Auckland',
  ),
  Country(
    countryName: 'South Africa',
    countryCode: '+27',
    flag: '🇿🇦',
    isoCode: 'ZA',
    digitCount: 9,
    timezone: 'Africa/Johannesburg',
  ),
  Country(
    countryName: 'France',
    countryCode: '+33',
    flag: '🇫🇷',
    isoCode: 'FR',
    digitCount: 9,
    timezone: 'Europe/Paris',
  ),
  Country(
    countryName: 'Japan',
    countryCode: '+81',
    flag: '🇯🇵',
    isoCode: 'JP',
    digitCount: 10,
    timezone: 'Asia/Tokyo',
  ),
];

class CountryCodeSelector extends StatefulWidget {
  final Country selectedCountry;
  final List<Country> countries;
  final ValueChanged<Country> onCountryChanged;

  const CountryCodeSelector({
    super.key,
    required this.selectedCountry,
    required this.countries,
    required this.onCountryChanged,
  });

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => _CountryPickerSheet(
          scrollController: scrollController,
          selectedCountry: widget.selectedCountry,
          countries: widget.countries,
          onSelect: (country) {
            widget.onCountryChanged(country);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: _showCountryPicker,
      borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.selectedCountry.countryCode,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: theme.colorScheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  final ScrollController scrollController;
  final Country selectedCountry;
  final List<Country> countries;
  final ValueChanged<Country> onSelect;

  const _CountryPickerSheet({
    required this.scrollController,
    required this.selectedCountry,
    required this.countries,
    required this.onSelect,
  });

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = widget.countries;
      } else {
        _filteredCountries = widget.countries
            .where((country) =>
                country.countryName.toLowerCase().contains(query.toLowerCase()) ||
                country.countryCode.contains(query) ||
                country.isoCode.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppUIConstants.radius.xl),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  AppStrings.auth.selectCountry,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCountries,
              decoration: InputDecoration(
                hintText: AppStrings.auth.searchCountry,
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.textMuted,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$12),
                ),
              ),
            ),
          ),
          const Divider(),
          // Country List
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              itemCount: _filteredCountries.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = country.countryCode == widget.selectedCountry.countryCode &&
                    country.countryName == widget.selectedCountry.countryName;

                return ListTile(
                  onTap: () => widget.onSelect(country),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        child: isSelected
                            ? Icon(
                                Icons.check_rounded,
                                color: theme.colorScheme.primary,
                                size: 20,
                              )
                            : null,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        country.flag,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  title: Text(
                    country.countryName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    country.countryCode,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.textMuted,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
