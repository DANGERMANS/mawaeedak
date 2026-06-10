import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Welcome Screen - Luxury Saudi Design
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const Spacer(),
                _buildLogo(),
                const SizedBox(height: AppSpacing.xl),
                _buildTitle(),
                const SizedBox(height: AppSpacing.md),
                _buildSubtitle(),
                const Spacer(),
                _buildFeatures(),
                const SizedBox(height: AppSpacing.xl),
                _buildButtons(context),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: AppColors.goldGradient,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: AppShadows.glass,
      ),
      child: const Icon(
        Icons.calendar_month_rounded,
        color: Colors.white,
        size: 60,
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'مواعيدك',
          style: GoogleFonts.cairo(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 4,
          width: 60,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      'كل مواعيدك في مكان واحد',
      style: GoogleFonts.cairo(
        fontSize: 18,
        color: AppColors.muted,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFeatures() {
    final features = [
      {'icon': Icons.schedule_rounded, 'title': 'المواعيد'},
      {'icon': Icons.account_balance_wallet_rounded, 'title': 'الرواتب'},
      {'icon': Icons.mosque_rounded, 'title': 'الصلوات'},
      {'icon': Icons.business_rounded, 'title': 'الخدمات'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((feature) {
        return Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: AppColors.gold,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              feature['title'] as String,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.card,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => context.goNamed('auth'),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'ابدأ الآن',
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'تصفح كضيف',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
