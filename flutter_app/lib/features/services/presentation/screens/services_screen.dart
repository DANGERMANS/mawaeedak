import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Services Screen - 100% Web Design Match
class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

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
                _buildServicesGrid(context),
                const SizedBox(height: 20),
                _buildCentersSection(context),
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
          'الخدمات',
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'مراكز الخدمات الحكومية',
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {'icon': Icons.work_outline, 'title': 'العمل', 'color': AppColors.gold},
      {'icon': Icons.school_outlined, 'title': 'التعليم', 'color': AppColors.success},
      {'icon': Icons.health_and_safety_outlined, 'title': 'الصحة', 'color': AppColors.error},
      {'icon': Icons.directions_car_outlined, 'title': 'المواصلات', 'color': AppColors.info},
      {'icon': Icons.home_work_outlined, 'title': 'الإسكان', 'color': AppColors.goldDark},
      {'icon': Icons.account_balance_outlined, 'title': 'الحج', 'color': AppColors.success},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(
          icon: service['icon'] as IconData,
          title: service['title'] as String,
          color: service['color'] as Color,
          onTap: () => context.pushNamed('centers-${service['title']}'),
        );
      },
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentersSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x3DC9A063), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A8A6B3D),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business_rounded,
                color: AppColors.gold,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'مراكز الخدمات',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildCenterItem(
            icon: Icons.work_history_rounded,
            title: 'مركز العمل',
            subtitle: '12 خدمة',
            color: AppColors.gold,
            onTap: () => context.pushNamed('centers-work'),
          ),
          _buildDivider(),
          _buildCenterItem(
            icon: Icons.school_rounded,
            title: 'مركز التعليم',
            subtitle: '8 خدمات',
            color: AppColors.success,
            onTap: () => context.pushNamed('centers-study'),
          ),
          _buildDivider(),
          _buildCenterItem(
            icon: Icons.flight_rounded,
            title: 'مركز السفر',
            subtitle: '5 خدمات',
            color: AppColors.info,
            onTap: () => context.pushNamed('centers-travel'),
          ),
          _buildDivider(),
          _buildCenterItem(
            icon: Icons.newspaper_rounded,
            title: 'مركز الأخبار',
            subtitle: '4 خدمات',
            color: AppColors.goldDark,
            onTap: () => context.pushNamed('centers-news'),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        height: 1,
        color: AppColors.border,
      ),
    );
  }

  Widget _buildCenterItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_left_rounded,
            color: AppColors.gold,
            size: 24,
          ),
        ],
      ),
    );
  }
}
