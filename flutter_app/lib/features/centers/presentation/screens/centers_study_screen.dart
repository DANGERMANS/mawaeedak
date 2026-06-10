import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات الدراسة
class CentersStudyScreen extends StatelessWidget {
  const CentersStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('خدمات الدراسة'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _ServiceCard(
            icon: Icons.school_outlined,
            title: 'التسجيل الدراسي',
            description: 'سجل في المدارس والجامعات',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.library_books_outlined,
            title: 'النتائج الدراسية',
            description: 'عرض نتائج الطلاب',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.menu_book_outlined,
            title: 'المكتبة الرقمية',
            description: 'الوصول للموارد التعليمية',
            onTap: () {},
          ),
          _ServiceCard(
            icon: Icons.calendar_today_outlined,
            title: 'الجدول الدراسي',
            description: 'عرض الجدول والمواعيد',
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
            color: const Color(0xFF7B68EE).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: const Color(0xFF7B68EE)),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}