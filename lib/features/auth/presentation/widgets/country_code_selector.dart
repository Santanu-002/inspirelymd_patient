import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/entities/country.dart';
import 'package:inspirelymd_patient/core/constants/app_ui_constants.dart';
import 'package:inspirelymd_patient/core/theme/color_scheme_extension.dart';
import 'package:inspirelymd_patient/features/auth/presentation/widgets/country_picker_sheet.dart';

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
        builder: (context, scrollController) => CountryPickerSheet(
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
        padding: EdgeInsets.symmetric(
          vertical: AppUIConstants.spacing.space$8,
          horizontal: AppUIConstants.spacing.space$4,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppUIConstants.spacing.space$2,
          children: [
            Text(
              widget.selectedCountry.countryCode,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
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
