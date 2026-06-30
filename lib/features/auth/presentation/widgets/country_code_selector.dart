import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class CountryCode {
  final String name;
  final String code;
  final String flag;

  const CountryCode({
    required this.name,
    required this.code,
    required this.flag,
  });
}

const List<CountryCode> defaultCountries = [
  CountryCode(name: 'United States', code: '+1', flag: '🇺🇸'),
  CountryCode(name: 'India', code: '+91', flag: '🇮🇳'),
  CountryCode(name: 'United Kingdom', code: '+44', flag: '🇬🇧'),
  CountryCode(name: 'Canada', code: '+1', flag: '🇨🇦'),
  CountryCode(name: 'Australia', code: '+61', flag: '🇦🇺'),
  CountryCode(name: 'Germany', code: '+49', flag: '🇩🇪'),
  CountryCode(name: 'United Arab Emirates', code: '+971', flag: '🇦🇪'),
  CountryCode(name: 'Singapore', code: '+65', flag: '🇸🇬'),
  CountryCode(name: 'New Zealand', code: '+64', flag: '🇳🇿'),
  CountryCode(name: 'South Africa', code: '+27', flag: '🇿🇦'),
  CountryCode(name: 'France', code: '+33', flag: '🇫🇷'),
  CountryCode(name: 'Japan', code: '+81', flag: '🇯🇵'),
];

class CountryCodeSelector extends StatefulWidget {
  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onCountryChanged;

  const CountryCodeSelector({
    super.key,
    required this.selectedCountry,
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
      borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppUIConstants.radius.radius$8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.selectedCountry.flag,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(width: 6),
            Text(
              widget.selectedCountry.code,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
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
  final CountryCode selectedCountry;
  final ValueChanged<CountryCode> onSelect;

  const _CountryPickerSheet({
    required this.scrollController,
    required this.selectedCountry,
    required this.onSelect,
  });

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  late List<CountryCode> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = defaultCountries;
  }

  void _filterCountries(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = defaultCountries;
      } else {
        _filteredCountries = defaultCountries
            .where((country) =>
                country.name.toLowerCase().contains(query.toLowerCase()) ||
                country.code.contains(query))
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

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppUIConstants.radius.xl),
        ),
      ),
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
                final isSelected = country.code == widget.selectedCountry.code &&
                    country.name == widget.selectedCountry.name;

                return ListTile(
                  onTap: () => widget.onSelect(country),
                  leading: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    country.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        country.code,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.textMuted,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (isSelected) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.check_rounded,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                      ],
                    ],
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
