import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة الدعم والمساعدة
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم والمساعدة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // FAQ Section
          Text(
            'الأسئلة الشائعة',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          _FAQItem(
            question: 'كيف أضيف موعداً جديداً؟',
            answer: 'اضغط على زر "+" في صفحة المواعيد وأدخل تفاصيل الموعد.',
          ),
          _FAQItem(
            question: 'كيف أغير لغة التطبيق؟',
            answer: 'يمكنك تغيير اللغة من الإعدادات > اللغة.',
          ),
          _FAQItem(
            question: 'كيف أستعيد كلمة المرور؟',
            answer: 'اضغط على "نسيت كلمة المرور" في صفحة تسجيل الدخول.',
          ),
          const SizedBox(height: AppSpacing.xl),

          // Contact Section
          Text(
            'تواصل معنا',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          _ContactCard(
            icon: Icons.email,
            title: 'البريد الإلكتروني',
            subtitle: 'support@mawaeedak.com',
          ),
          _ContactCard(
            icon: Icons.phone,
            title: 'الهاتف',
            subtitle: '+966 XX XXX XXXX',
          ),
          _ContactCard(
            icon: Icons.chat,
            title: 'الدردشة',
            subtitle: 'متاحة 24/7',
          ),
          const SizedBox(height: AppSpacing.xl),

          // Feedback Section
          Text(
            'أرسل لنا رأيك',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'اكتب رأيك أو اقتراحك هنا...',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ElevatedButton(
            onPressed: () {},
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ExpansionTile(
        title: Text(widget.question),
        iconColor: AppColors.gold,
        onExpansionChanged: (expanded) {
          setState(() => _isExpanded = expanded);
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(widget.answer),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
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
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}