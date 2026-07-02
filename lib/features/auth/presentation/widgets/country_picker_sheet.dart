import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/button/app_icon_button.dart';
import 'package:inspirelymd_patient/core/common/widgets/text_field/app_text_field.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';

class CountryPickerSheet extends StatefulWidget {
  final ScrollController scrollController;
  final Country selectedCountry;
  final List<Country> countries;
  final ValueChanged<Country> onSelect;

  const CountryPickerSheet({
    super.key,
    required this.scrollController,
    required this.selectedCountry,
    required this.countries,
    required this.onSelect,
  });

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
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
            .where(
              (country) =>
                  country.countryName.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ||
                  country.countryCode.contains(query) ||
                  country.isoCode.toLowerCase().contains(query.toLowerCase()),
            )
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
              margin: EdgeInsets.symmetric(
                vertical: AppUIConstants.spacing.space$12,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Title
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppUIConstants.spacing.containerPadding,
              vertical: AppUIConstants.spacing.space$8,
            ),
            child: Row(
              children: [
                Text(
                  AppStrings.auth.selectCountry,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                AppIconButton.ghost(
                  icon: Icons.close_rounded,
                  iconColor: theme.colorScheme.onSurface,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppUIConstants.spacing.containerPadding,
              vertical: AppUIConstants.spacing.space$8,
            ),
            child: AppTextField(
              controller: _searchController,
              onChanged: _filterCountries,
              hintText: AppStrings.auth.searchCountry,
              prefixIcon: Icons.search_rounded,
            ),
          ),
          const Divider(),
          // Country List
          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              itemCount: _filteredCountries.length,
              padding: EdgeInsets.symmetric(
                horizontal: AppUIConstants.spacing.space$12,
              ),
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected =
                    country.countryCode == widget.selectedCountry.countryCode &&
                    country.countryName == widget.selectedCountry.countryName;

                return ListTile(
                  onTap: () => widget.onSelect(country),
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: AppUIConstants.spacing.space$8,
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
                      Text(country.flag, style: theme.textTheme.headlineMedium),
                    ],
                  ),
                  title: Text(
                    country.countryName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    country.countryCode,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.textMuted,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
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
