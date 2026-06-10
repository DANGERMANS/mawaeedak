import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات العمل
class CentersWorkScreen extends StatelessWidget {
  const CentersWorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خدمات العمل'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _ServiceCard(
            icon: Icons.badge_outlined,
            title: 'تحديث السيرة الذاتية',
            description: 'حدث بياناتك الوظيفية',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.search,
            title: 'بحث عن وظائف',
            description: 'ابحث عن فرص عمل مناسبة',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.school_outlined,
            title: 'التدريب المهني',
            description: 'سجل في برامج التدريب',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.description_outlined,
            title: 'تصاريح العمل',
            description: 'تجديد وتصاريح العمل',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: AppColors.gold),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}