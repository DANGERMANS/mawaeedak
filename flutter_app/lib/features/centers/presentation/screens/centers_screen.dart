import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Centers Screen - 100% Web Design Match
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 20),
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
        const SizedBox(height: 4),
        Text(
          'جميع المراكز الحكومية في مكان واحد',
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.muted,
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
    ];

    return Column(
      children: centers.map((center) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF7),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0x3DC9A063), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A8A6B3D),
                blurRadius: 30,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: (center['color'] as Color).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        center['icon'] as IconData,
                        color: center['color'] as Color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            center['title'] as String,
                            style: GoogleFonts.cairo(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
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
                              borderRadius: BorderRadius.circular(8),
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
