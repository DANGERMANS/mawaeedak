import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة الخصوصية
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'سياسة الخصوصية',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            _PrivacySection(
              title: 'المعلومات التي نجمعها',
              icon: Icons.info_outline,
              content: '''نجمع المعلومات التالية:
• معلومات الحساب (الاسم، البريد الإلكتروني)
• معلومات المواعيد والأحداث
• معلومات مالية (الرواتب والمصروفات)
• تفضيلات المستخدم''',
            ),
            _PrivacySection(
              title: 'كيفية استخدام المعلومات',
              icon: Icons.usage,
              content: '''نستخدم معلوماتك لـ:
• تقديم خدماتنا وتحسينها
• إشعارات المواعيد والتذكيرات
• تحسين تجربة المستخدم
• الأمان ومنع الاحتيال''',
            ),
            _PrivacySection(
              title: 'حماية المعلومات',
              icon: Icons.security,
              content: '''نحن نستخدم إجراءات أمان متقدمة لحماية معلوماتك، بما في ذلك:
• تشفير البيانات
• جدران الحماية
• التحكم في الوصول''',
            ),
            _PrivacySection(
              title: 'مشاركة المعلومات',
              icon: Icons.share,
              content: '''لا نشارك معلوماتك الشخصية مع أطراف ثالثة إلا في الحالات التالية:
• بموافقتك الصريحة
• للامتثال للقانون
• لحماية حقوقنا''',
            ),
            _PrivacySection(
              title: 'حقوقك',
              icon: Icons.person,
              content: '''لديك الحق في:
• الوصول لبياناتك
• تصحيح البيانات
• حذف البيانات
• الاعتراض على المعالجة''',
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

class _PrivacySection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const _PrivacySection({
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.gold),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}