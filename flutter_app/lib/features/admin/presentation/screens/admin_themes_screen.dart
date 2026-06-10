import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة المظاهر - الأدمن
class AdminThemesScreen extends StatefulWidget {
  const AdminThemesScreen({super.key});

  @override
  State<AdminThemesScreen> createState() => _AdminThemesScreenState();
}

class _AdminThemesScreenState extends State<AdminThemesScreen> {
  String _selectedTheme = 'gold';
  bool _darkMode = false;

  final List<_ThemeItem> _themes = [
    _ThemeItem(
      id: 'gold',
      name: 'ذهبي فاخر',
      primary: AppColors.gold,
      description: 'الثيم الذهبي السعودي الفاخر',
    ),
    _ThemeItem(
      id: 'blue',
      name: 'أزرق كلاسيكي',
      primary: const Color(0xFF4A90A4),
      description: 'ثيم أزرق هادئ',
    ),
    _ThemeItem(
      id: 'green',
      name: 'أخضر طبيعي',
      primary: const Color(0xFF2ECC71),
      description: 'ثيم أخضر منعش',
    ),
    _ThemeItem(
      id: 'purple',
      name: 'بنفسجي أنيق',
      primary: const Color(0xFF7B68EE),
      description: 'ثيم بنفسجي راقي',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المظاهر'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Theme Selection
          Text(
            'اختر الثيم',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          ..._themes.map((theme) => _ThemeCard(
                theme: theme,
                isSelected: _selectedTheme == theme.id,
                onTap: () => setState(() => _selectedTheme = theme.id),
              )),

          const SizedBox(height: AppSpacing.lg),

          // Dark Mode
          Card(
            child: SwitchListTile(
              title: const Text('الوضع الداكن'),
              subtitle: const Text('تفعيل المظهر الداكن'),
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              secondary: const Icon(Icons.dark_mode),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Customization
          Text(
            'تخصيص الألوان',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          _ColorPickerCard(
            title: 'اللون الأساسي',
            color: AppColors.gold,
            onColorChanged: (color) {},
          ),
          _ColorPickerCard(
            title: 'لون النص',
            color: AppColors.textPrimary,
            onColorChanged: (color) {},
          ),
          _ColorPickerCard(
            title: 'لون الخلفية',
            color: AppColors.paper,
            onColorChanged: (color) {},
          ),
        ],
      ),
    );
  }
}

class _ThemeItem {
  final String id;
  final String name;
  final Color primary;
  final String description;

  const _ThemeItem({
    required this.id,
    required this.name,
    required this.primary,
    required this.description,
  });
}

class _ThemeCard extends StatelessWidget {
  final _ThemeItem theme;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.lightGold : null,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(Icons.palette, color: theme.primary),
        ),
        title: Text(theme.name),
        subtitle: Text(theme.description),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: AppColors.gold)
            : const Icon(Icons.circle_outlined),
        onTap: onTap,
      ),
    );
  }
}

class _ColorPickerCard extends StatelessWidget {
  final String title;
  final Color color;
  final Function(Color) onColorChanged;

  const _ColorPickerCard({
    required this.title,
    required this.color,
    required this.onColorChanged,
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
            color: color,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
        ),
        title: Text(title),
        subtitle: Text('#${color.value.toRadixString(16).substring(2).toUpperCase()}'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
      ),
    );
  }
}