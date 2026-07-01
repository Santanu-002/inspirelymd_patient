import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspirelymd_patient/core/constants/app_icons.dart';

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
    final activeColor = theme.colorScheme.primary; // Brand red
    final inactiveColor = theme.colorScheme.onSurface.withValues(alpha: 0.4);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(color: theme.colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: AppIcons.navigation.home,
                activeIcon: AppIcons.navigation.home,
                label: 'Home',
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _buildNavItem(
                index: 1,
                icon: AppIcons.navigation.programs,
                activeIcon: AppIcons.navigation.programs,
                label: 'Programs',
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _buildNavItem(
                index: 2,
                icon: AppIcons.navigation.messagesInactive,
                activeIcon: AppIcons.navigation.messagesActive,
                label: 'Messages',
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                badgeValue: 1,
              ),
              _buildNavItem(
                index: 3,
                icon: AppIcons.navigation.pharmacy,
                activeIcon: AppIcons.navigation.pharmacy,
                label: 'Pharmacy',
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
              _buildNavItem(
                index: 4,
                icon: AppIcons.navigation.accountInactive,
                activeIcon: AppIcons.navigation.accountActive,
                label: 'Account',
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required Color activeColor,
    required Color inactiveColor,
    int? badgeValue,
  }) {
    final isActive = currentIndex == index;
    final color = isActive ? activeColor : inactiveColor;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(isActive ? activeIcon : icon, color: color, size: 26),
                if (badgeValue != null && badgeValue > 0)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          badgeValue.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
