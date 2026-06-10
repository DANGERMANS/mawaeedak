import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

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
                Text('خدماتك', style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.2)),
                const SizedBox(height: 4),
                Text('أقسامك اليومية المعتمدة داخل مواعيدك', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted)),
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

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {'icon': Icons.event_available_rounded, 'title': 'نظم مواعيدك', 'subtitle': 'إضافة وتعديل وحفظ المواعيد', 'route': '/calendar', 'color': AppColors.gold},
      {'icon': Icons.flight_takeoff_rounded, 'title': 'رحلاتي القادمة', 'subtitle': 'الرحلات وقائمة التجهيزات', 'route': '/travel', 'color': AppColors.info},
      {'icon': Icons.campaign_rounded, 'title': 'الشكاوي والاقتراحات', 'subtitle': 'صوتك مسموع ومتابعة الطلبات', 'route': '/voice', 'color': AppColors.warning},
      {'icon': Icons.card_giftcard_rounded, 'title': 'قدم تهنئة لمن تريد', 'subtitle': 'قوالب تهنئة ومشاركة', 'route': '/centers/greetings', 'color': AppColors.goldDark},
      {'icon': Icons.support_agent_rounded, 'title': 'اتصل بنا', 'subtitle': 'رسائل الدعم والتواصل', 'route': '/support', 'color': AppColors.success},
      {'icon': Icons.article_rounded, 'title': 'الأخبار', 'subtitle': 'أخبار مختارة ومحدثة', 'route': '/news-jobs', 'color': AppColors.info},
      {'icon': Icons.work_rounded, 'title': 'الوظائف', 'subtitle': 'فرص عمل محفوظة ومفلترة', 'route': '/news-jobs', 'color': AppColors.success},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.05),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return GestureDetector(
          onTap: () => context.push(service['route'] as String),
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
                  decoration: BoxDecoration(color: (service['color'] as Color).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
                  child: Icon(service['icon'] as IconData, color: service['color'] as Color, size: 28),
                ),
                const SizedBox(height: 12),
                Text(service['title'] as String, style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink), textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text(service['subtitle'] as String, style: GoogleFonts.cairo(fontSize: 11, color: AppColors.muted), textAlign: TextAlign.center, maxLines: 2),
              ],
            ),
          ),
        );
      },
    );
  }
}
