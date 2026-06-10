import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات التهنئة
class CentersGreetingsScreen extends StatelessWidget {
  const CentersGreetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التبريكات والمناسبات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _GreetingCard(
            icon: Icons.celebration,
            title: 'عيد ميلاد',
            color: const Color(0xFFFFB347),
            onTap: () {},
          ),
          _GreetingCard(
            icon: Icons.cake,
            title: 'خطوبة',
            color: const Color(0xFFFF69B4),
            onTap: () {},
          ),
          _GreetingCard(
            icon: Icons.favorite,
            title: 'زواج',
            color: const Color(0xFFFF6B6B),
            onTap: () {},
          ),
          _GreetingCard(
            icon: Icons.child_friendly,
            title: 'ولادة',
            color: const Color(0xFF4FC3F7),
            onTap: () {},
          ),
          _GreetingCard(
            icon: Icons.school,
            title: 'تخرج',
            color: const Color(0xFF7B68EE),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _GreetingCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}