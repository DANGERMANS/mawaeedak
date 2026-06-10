import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Services Screen - صفحة الخدمات (9 خدمات)
class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
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
        Text('الخدمات', style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.2)),
        const SizedBox(height: 4),
        Text('خدمات منظمة تساعدك في يومك', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted)),
      ],
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {'icon': Icons.track_changes_rounded, 'title': 'احسب هدفك', 'subtitle': 'حدد أهدافك وتابع تقدمك', 'route': '/goal-calculator', 'color': AppColors.gold},
      {'icon': Icons.calculate_rounded, 'title': 'حساب التكاليف', 'subtitle': 'تكييف هدفك المالي', 'route': '/cost-calculator', 'color': AppColors.success},
      {'icon': Icons.notifications_active_rounded, 'title': 'ذكرني', 'subtitle': 'تذكيرات مخصصة', 'route': '/reminder', 'color': AppColors.info},
      {'icon': Icons.mosque_rounded, 'title': 'الأذكار', 'subtitle': 'أذكار الصباح والمساء', 'route': '/athkar', 'color': AppColors.goldDark},
      {'icon': Icons.record_voice_over_rounded, 'title': 'صوتك مسموع', 'subtitle': 'شكاوى واقتراحات', 'route': '/voice', 'color': AppColors.warning},
      {'icon': Icons.work_history_rounded, 'title': 'الوظائف والأخبار', 'subtitle': 'وظائف وأخبار جديدة', 'route': '/news-jobs', 'color': AppColors.success},
      {'icon': Icons.calendar_today_rounded, 'title': 'بطاقة اليوم', 'subtitle': 'أنشئ بطاقة يومية', 'route': '/daily-card', 'color': AppColors.gold},
      {'icon': Icons.flight_rounded, 'title': 'السفر', 'subtitle': 'رحلات ومستندات', 'route': '/travel', 'color': AppColors.info},
      {'icon': Icons.school_rounded, 'title': 'الدراسة والإجازات', 'subtitle': 'مواعيد دراسية', 'route': '/study', 'color': AppColors.goldDark},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.05),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(
          context,
          icon: service['icon'] as IconData,
          title: service['title'] as String,
          subtitle: service['subtitle'] as String,
          color: service['color'] as Color,
          route: service['route'] as String,
        );
      },
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String route,
  }) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF7),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0x3DC9A063)),
          boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 30, offset: Offset(0, 12))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(title, style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink), textAlign: TextAlign.center),
            const SizedBox(height: 4),
            Text(subtitle, style: GoogleFonts.cairo(fontSize: 11, color: AppColors.muted), textAlign: TextAlign.center, maxLines: 2),
          ],
        ),
      ),
    );
  }
}
