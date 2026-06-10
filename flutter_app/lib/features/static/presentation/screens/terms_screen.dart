import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة الشروط والأحكام
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشروط والأحكام'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الشروط والأحكام',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            _TermsSection(
              title: '1. القبول',
              content: '''باستخدام تطبيق "مواعيدك"، فإنك توافق على هذه الشروط والأحكام. إذا كنت لا توافق على أي جزء من هذه الشروط، فلا يجوز لك استخدام التطبيق.''',
            ),
            _TermsSection(
              title: '2. الاستخدام',
              content: '''يقتصر استخدامك للتطبيق على الأغراض الشخصية وغير التجارية. يُحظر عليك تعديل التطبيق أو نسخه أو توزيعه أو إنشاء أعمال مشتقة منه.''',
            ),
            _TermsSection(
              title: '3. الحساب',
              content: '''أنت مسؤول عن الحفاظ على سرية حسابك وكلمة المرور. يجب أن تبلغنا فوراً عن أي استخدام غير مصرح به لحسابك.''',
            ),
            _TermsSection(
              title: '4. الخصوصية',
              content: '''نحن نجمع ونستخدم معلوماتك الشخصية وفقاً لسياسة الخصوصية الخاصة بنا. باستخدامك للتطبيق، فإنك توافق على جمع واستخدام المعلومات وفقاً لهذه السياسة.''',
            ),
            _TermsSection(
              title: '5. حدود المسؤولية',
              content: '''لا يتحمل التطبيق أي مسؤولية عن أي أضرار مباشرة أو غير مباشرة ناتجة عن استخدام التطبيق أو عدم القدرة على استخدامه.''',
            ),
            _TermsSection(
              title: '6. التعديلات',
              content: '''نحتفظ بالحق في تعديل هذه الشروط في أي وقت. ستُعلمك بأي تغييرات جوهرية من خلال إشعار في التطبيق.''',
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

class _TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const _TermsSection({required this.title, required this.content});

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