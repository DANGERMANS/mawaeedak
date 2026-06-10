import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_theme.dart';

/// Main Scaffold with Bottom Navigation
/// Order: الرئيسية, الرواتب, خدماتك, التقويم, المزيد
class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/salary')) return 1;
    if (location.startsWith('/services')) return 2;
    if (location.startsWith('/calendar')) return 3;
    if (location.startsWith('/more')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/salary');
        break;
      case 2:
        context.go('/services');
        break;
      case 3:
        context.go('/calendar');
        break;
      case 4:
        context.go('/more');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getCurrentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x1E8A6B3D),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context,
                  index: 0,
                  icon: Icons.home_rounded,
                  label: 'الرئيسية',
                  isSelected: currentIndex == 0,
                ),
                _buildNavItem(
                  context,
                  index: 1,
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'الرواتب',
                  isSelected: currentIndex == 1,
                ),
                _buildNavItem(
                  context,
                  index: 2,
                  icon: Icons.grid_view_rounded,
                  label: 'خدماتك',
                  isSelected: currentIndex == 2,
                ),
                _buildNavItem(
                  context,
                  index: 3,
                  icon: Icons.calendar_month_rounded,
                  label: 'التقويم',
                  isSelected: currentIndex == 3,
                ),
                _buildNavItem(
                  context,
                  index: 4,
                  icon: Icons.more_horiz_rounded,
                  label: 'المزيد',
                  isSelected: currentIndex == 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTap(context, index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.gold.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isSelected ? AppColors.gold : AppColors.muted,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppColors.gold : AppColors.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
