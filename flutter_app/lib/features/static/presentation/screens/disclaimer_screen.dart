import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة إخلاء المسؤولية
class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إخلاء المسؤولية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'إخلاء المسؤولية',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              '''تطبيق "مواعيدك" هو تطبيق لإدارة المواعيد الشخصية والمالية، ولا يُعتبر بديلاً عن الاستشارات المالية أو القانونية المتخصصة.''',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            _DisclaimerSection(
              title: 'دقة المعلومات',
              content: 'نسعى لتقديم معلومات دقيقة، لكننا لا نضمن اكتمالها أو خلوها من الأخطاء.',
            ),
            _DisclaimerSection(
              title: 'المواقيت',
              content: 'مواقيت الصلاة المعروضة هي تقريبية وقد تختلف حسب الموقع الجغرافي.',
            ),
            _DisclaimerSection(
              title: 'المالية',
              content: 'لا يتحمل التطبيق أي مسؤولية عن القرارات المالية التي يتخذها المستخدم بناءً على المعلومات المقدمة.',
            ),
            _DisclaimerSection(
              title: 'الروابط',
              content: 'قد يحتوي التطبيق على روابط لمواقع خارجية، ونحن غير مسؤولين عن محتوى تلك المواقع.',
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'آخر تحديث: 2026-06-10',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _DisclaimerSection extends StatelessWidget {
  final String title;
  final String content;

  const _DisclaimerSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}