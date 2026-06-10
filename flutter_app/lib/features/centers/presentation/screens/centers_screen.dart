import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

/// مراكز الخدمات الحكومية
class CentersScreen extends StatelessWidget {
  const CentersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final centers = [
      _CenterItem(
        icon: Icons.work_outline,
        title: 'العمل',
        subtitle: 'خدمات التوظيف والتدريب المهني',
        color: const Color(0xFF4A90A4),
        onTap: () => context.push('/centers/work'),
      ),
      _CenterItem(
        icon: Icons.school_outlined,
        title: 'الدراسة',
        subtitle: 'خدمات التعليم والتدريب',
        color: const Color(0xFF7B68EE),
        onTap: () => context.push('/centers/study'),
      ),
      _CenterItem(
        icon: Icons.flight_outlined,
        title: 'السفر',
        subtitle: 'خدمات التأشيرات والجوازات',
        color: const Color(0xFF20B2AA),
        onTap: () => context.push('/centers/travel'),
      ),
      _CenterItem(
        icon: Icons.newspaper_outlined,
        title: 'الأخبار',
        subtitle: 'آخر الأخبار والتصاريح',
        color: const Color(0xFFFF6B6B),
        onTap: () => context.push('/centers/news'),
      ),
      _CenterItem(
        icon: Icons.card_giftcard_outlined,
        title: 'التبريكات',
        subtitle: 'خدمات التهنئة والمناسبات',
        color: const Color(0xFFFFB347),
        onTap: () => context.push('/centers/greetings'),
      ),
      _CenterItem(
        icon: Icons.report_problem_outlined,
        title: 'الشكاوى',
        subtitle: 'تقديم الشكاوى والمقترحات',
        color: const Color(0xFFFF6B6B),
        onTap: () => context.push('/centers/complaints'),
      ),
      _CenterItem(
        icon: Icons.business_center_outlined,
        title: 'الوظائف',
        subtitle: 'فرص عمل وتوظيف',
        color: const Color(0xFF2ECC71),
        onTap: () => context.push('/centers/jobs'),
      ),
      _CenterItem(
        icon: Icons.more_horiz,
        title: 'المزيد',
        subtitle: 'خدمات أخرى',
        color: AppColors.brown,
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('مراكز الخدمات'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: centers.length,
        itemBuilder: (context, index) {
          final center = centers[index];
          return _CenterCard(item: center);
        },
      ),
    );
  }
}

class _CenterItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _CenterItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}

class _CenterCard extends StatelessWidget {
  final _CenterItem item;

  const _CenterCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 28,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.brown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}