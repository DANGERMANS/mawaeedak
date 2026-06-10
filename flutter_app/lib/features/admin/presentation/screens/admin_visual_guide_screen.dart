import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// الدليل المرئي - الأدمن
class AdminVisualGuideScreen extends StatelessWidget {
  const AdminVisualGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدليل المرئي'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Brand Colors
          _GuideSection(
            title: 'ألوان العلامة',
            children: [
              _ColorSample(name: 'ذهبي', color: AppColors.gold),
              _ColorSample(name: 'بني', color: AppColors.brown),
              _ColorSample(name: 'داكن', color: AppColors.ink),
              _ColorSample(name: 'كريمي', color: AppColors.cream),
              _ColorSample(name: 'ورقي', color: AppColors.paper),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Typography
          _GuideSection(
            title: 'الخطوط',
            children: [
              Text('Display Large', style: Theme.of(context).textTheme.displayLarge),
              Text('Display Medium', style: Theme.of(context).textTheme.displayMedium),
              Text('Title Large', style: Theme.of(context).textTheme.titleLarge),
              Text('Title Medium', style: Theme.of(context).textTheme.titleMedium),
              Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
              Text('Body Medium', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Components
          _GuideSection(
            title: 'المكونات',
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Elevated Button'),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Outlined Button'),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () {},
                child: const Text('Text Button'),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Text Field',
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: ListTile(
                  title: const Text('Card Item'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Icons
          _GuideSection(
            title: 'الأيقونات',
            children: [
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                children: const [
                  _IconSample(icon: Icons.home),
                  _IconSample(icon: Icons.calendar_today),
                  _IconSample(icon: Icons.attach_money),
                  _IconSample(icon: Icons.mosque),
                  _IconSample(icon: Icons.notifications),
                  _IconSample(icon: Icons.settings),
                  _IconSample(icon: Icons.person),
                  _IconSample(icon: Icons.search),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Spacing
          _GuideSection(
            title: 'المسافات',
            children: [
              Row(
                children: [
                  _SpacingBox(size: AppSpacing.xs),
                  _SpacingBox(size: AppSpacing.sm),
                  _SpacingBox(size: AppSpacing.md),
                  _SpacingBox(size: AppSpacing.lg),
                  _SpacingBox(size: AppSpacing.xl),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Border Radius
          _GuideSection(
            title: 'حواف مستديرة',
            children: [
              Row(
                children: [
                  _RadiusBox(radius: AppRadius.sm),
                  _RadiusBox(radius: AppRadius.md),
                  _RadiusBox(radius: AppRadius.lg),
                  _RadiusBox(radius: AppRadius.xl),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GuideSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _GuideSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        ...children,
      ],
    );
  }
}

class _ColorSample extends StatelessWidget {
  final String name;
  final Color color;

  const _ColorSample({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
        ),
        title: Text(name),
        subtitle: Text('#${color.value.toRadixString(16).substring(2).toUpperCase()}'),
      ),
    );
  }
}

class _IconSample extends StatelessWidget {
  final IconData icon;

  const _IconSample({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Icon(icon, color: AppColors.gold),
    );
  }
}

class _SpacingBox extends StatelessWidget {
  final double size;

  const _SpacingBox({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '${size.toInt()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _RadiusBox extends StatelessWidget {
  final double radius;

  const _RadiusBox({required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 40,
      margin: const EdgeInsets.only(left: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.2),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.gold),
      ),
      child: Center(
        child: Text(
          '${radius.toInt()}',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}