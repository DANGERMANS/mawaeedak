import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات السفر
class CentersTravelScreen extends StatelessWidget {
  const CentersTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خدمات السفر'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _ServiceCard(
            icon: Icons.flight,
            title: 'حجز الرحلات',
            description: 'احجز رحلتك بسهولة',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.card_membership,
            title: 'التأشيرات',
            description: 'قدم على تأشيرة السفر',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.book_outlined,
            title: 'الجوازات',
            description: 'تجديد واستخراج جواز السفر',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.hotel,
            title: 'حجز الفنادق',
            description: 'ابحث واحجز فنادق',
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
            color: const Color(0xFF20B2AA).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: const Color(0xFF20B2AA)),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}