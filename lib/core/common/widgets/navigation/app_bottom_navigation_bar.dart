import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/common/widgets/navigation/app_bottom_nav_item.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';
import 'package:inspirelymd_patient/core/constants/app_strings.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.onSurfaceVariant;

    const unreadMessagesCount = 1;

    final navItems = [
      {
        'index': 0,
        'icon': AppIcons.navigation.home,
        'activeIcon': AppIcons.navigation.home,
        'label': AppStrings.common.navHome,
      },
      {
        'index': 1,
        'icon': AppIcons.navigation.programs,
        'activeIcon': AppIcons.navigation.programs,
        'label': AppStrings.common.navPrograms,
      },
      {
        'index': 2,
        'icon': AppIcons.navigation.messagesInactive,
        'activeIcon': AppIcons.navigation.messagesActive,
        'label': AppStrings.common.navMessages,
        'badgeValue': unreadMessagesCount,
      },
      {
        'index': 3,
        'icon': AppIcons.navigation.pharmacy,
        'activeIcon': AppIcons.navigation.pharmacy,
        'label': AppStrings.common.navPharmacy,
      },
      {
        'index': 4,
        'icon': AppIcons.navigation.accountInactive,
        'activeIcon': AppIcons.navigation.accountActive,
        'label': AppStrings.common.navAccount,
      },
    ];

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: navItems.map((item) {
            return AppBottomNavItem(
              index: item['index'] as int,
              currentIndex: currentIndex,
              icon: item['icon'] as IconData,
              activeIcon: item['activeIcon'] as IconData,
              label: item['label'] as String,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              badgeValue: item['badgeValue'] as int?,
              onTap: onTap,
            );
          }).toList(),
        ),
      ),
    );
  }
}
