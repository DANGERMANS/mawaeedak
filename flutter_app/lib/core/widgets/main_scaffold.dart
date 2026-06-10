import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

/// Main Scaffold with Glass Morphism Bottom Navigation
class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      extendBody: true,
      bottomNavigationBar: const _GlassBottomNavBar(),
    );
  }
}

class _GlassBottomNavBar extends StatelessWidget {
  const _GlassBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _getIndexFromLocation(location);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceOverlay,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.glass,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: TabConfig.tabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tab = entry.value;
                final isSelected = currentIndex == index;
                
                return _NavTab(
                  icon: _getIconData(tab['icon']!),
                  label: tab['label']!,
                  isSelected: isSelected,
                  onTap: () => _navigateToTab(context, tab['name']!),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  int _getIndexFromLocation(String location) {
    for (int i = 0; i < TabConfig.tabs.length; i++) {
      if (location.startsWith('/${TabConfig.tabs[i]['name']}')) {
        return i;
      }
    }
    return 0;
  }

  void _navigateToTab(BuildContext context, String tabName) {
    context.goNamed(tabName);
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home_outlined;
      case 'attach_money':
        return Icons.account_balance_wallet_outlined;
      case 'grid_view':
        return Icons.apps_outlined;
      case 'calendar_today':
        return Icons.calendar_today_outlined;
      case 'more_horiz':
        return Icons.more_horiz_outlined;
      default:
        return Icons.circle_outlined;
    }
  }
}

class _NavTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavTab({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.gold.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                size: 24,
                color: isSelected ? AppColors.gold : AppColors.muted,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.gold : AppColors.muted,
              ),
              child: Text(label),
            ),
            if (isSelected) ...[
              const SizedBox(height: 6),
              Container(
                width: 20,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(1.5),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}