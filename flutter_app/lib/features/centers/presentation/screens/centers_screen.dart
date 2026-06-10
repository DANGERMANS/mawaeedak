import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Centers Screen - Luxury Saudi Design
class CentersScreen extends ConsumerWidget {
  const CentersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),
                _buildHeader(),
                const SizedBox(height: AppSpacing.lg),
                _buildCentersList(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مراكز الخدمات',
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
            height: 1.2,
          ),
        ),
        Text(
          'جميع المراكز الحكومية في مكان واحد',
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.muted,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildCentersList(BuildContext context) {
    final centers = [
      {'icon': Icons.work_history_rounded, 'title': 'مركز العمل', 'subtitle': 'خدمات التوظيف والتدريب', 'count': '12', 'color': AppColors.gold},
      {'icon': Icons.school_rounded, 'title': 'مركز التعليم', 'subtitle': 'القبول والتسجيل والاختبارات', 'count': '8', 'color': AppColors.success},
      {'icon': Icons.flight_rounded, 'title': 'مركز السفر', 'subtitle': 'التأشيرات والجوازات', 'count': '5', 'color': AppColors.info},
      {'icon': Icons.newspaper_rounded, 'title': 'مركز الأخبار', 'subtitle': 'الأخبار والتصريحات', 'count': '4', 'color': AppColors.goldDark},
      {'icon': Icons.people_rounded, 'title': 'مركز التهنئة', 'subtitle': 'المناسبات والأعياد', 'count': '3', 'color': AppColors.warning},
      {'icon': Icons.business_center_rounded, 'title': 'مركز الشكاوى', 'subtitle': 'تقديم الشكاوى ومتابعتها', 'count': '6', 'color': AppColors.error},
      {'icon': Icons.work_rounded, 'title': 'مركز الوظائف', 'subtitle': 'فرص العمل المتاحة', 'count': '9', 'color': AppColors.gold},
    ];

    return Column(
      children: centers.map((center) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: AppShadows.card,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppRadius.xxl),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: (center['color'] as Color).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Icon(
                        center['icon'] as IconData,
                        color: center['color'] as Color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            center['title'] as String,
                            style: GoogleFonts.cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            center['subtitle'] as String,
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              '${center['count']} خدمات',
                              style: GoogleFonts.cairo(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.gold,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
