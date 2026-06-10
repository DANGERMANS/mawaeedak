import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة المرجع - Reference Clone
class ReferenceCloneScreen extends StatelessWidget {
  const ReferenceCloneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مرجع التطبيق'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // App Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      size: 40,
                      color: AppColors.gold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'مواعيدك',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'الإصدار 1.0.0',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Features Reference
          Text(
            'الميزات الرئيسية',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          _FeatureReference(
            title: 'المواعيد',
            description: 'إدارة المواعيد الشخصية',
            icon: Icons.event,
          ),
          _FeatureReference(
            title: 'المالية',
            description: 'تتبع الرواتب والمصروفات',
            icon: Icons.attach_money,
          ),
          _FeatureReference(
            title: 'الصلاة',
            description: 'مواقيت الصلاة والتذكير',
            icon: Icons.mosque,
          ),
          _FeatureReference(
            title: 'المراكز',
            description: 'خدمات حكومية',
            icon: Icons.business,
          ),

          const SizedBox(height: AppSpacing.lg),

          // Technical Reference
          Text(
            'المرجع التقني',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          _TechReference(
            title: 'Flutter',
            description: 'إطار العمل: Flutter 3.x',
          ),
          _TechReference(
            title: 'GoRouter',
            description: 'التوجيه: go_router',
          ),
          _TechReference(
            title: 'Riverpod',
            description: 'إدارة الحالة: flutter_riverpod',
          ),
          _TechReference(
            title: 'Supabase',
            description: 'قاعدة البيانات: Supabase',
          ),
        ],
      ),
    );
  }
}

class _FeatureReference extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _FeatureReference({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: AppColors.gold),
        ),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}

class _TechReference extends StatelessWidget {
  final String title;
  final String description;

  const _TechReference({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}