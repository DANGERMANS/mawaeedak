import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إعدادات الأدمن
class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // App Settings
          _SettingsSection(
            title: 'إعدادات التطبيق',
            children: [
              _SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'الإشعارات',
                subtitle: 'إدارة إعدادات الإشعارات',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.language,
                title: 'اللغة',
                subtitle: 'العربية',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.dark_mode_outlined,
                title: 'المظهر',
                subtitle: 'فاتح / داكن',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Data Settings
          _SettingsSection(
            title: 'إعدادات البيانات',
            children: [
              _SettingsTile(
                icon: Icons.backup_outlined,
                title: 'نسخ احتياطي',
                subtitle: 'إنشاء نسخة احتياطية',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.restore,
                title: 'استعادة',
                subtitle: 'استعادة من نسخة سابقة',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.delete_sweep_outlined,
                title: 'مسح البيانات',
                subtitle: 'حذف جميع البيانات',
                onTap: () => _showDeleteConfirmation(context),
                isDestructive: true,
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Security Settings
          _SettingsSection(
            title: 'الأمان',
            children: [
              _SettingsTile(
                icon: Icons.security,
                title: 'كلمة المرور',
                subtitle: 'تغيير كلمة المرور',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.fingerprint,
                title: 'المصادقة الثنائية',
                subtitle: 'تفعيل المصادقة الثنائية',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // About
          _SettingsSection(
            title: 'حول',
            children: [
              _SettingsTile(
                icon: Icons.info_outline,
                title: 'معلومات التطبيق',
                subtitle: 'الإصدار 1.0.0',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: 'الشروط والأحكام',
                subtitle: 'عرض شروط الاستخدام',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'الخصوصية',
                subtitle: 'سياسة الخصوصية',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.logout,
                title: 'تسجيل الخروج',
                subtitle: 'الخروج من حسابك',
                onTap: () => _showLogoutConfirmation(context),
                isDestructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text(
          'هل أنت متأكد من حذف جميع البيانات؟ لا يمكن التراجع عن هذا الإجراء.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم حذف البيانات'),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل تريد تسجيل الخروج من حسابك؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: AppSpacing.md,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.brown,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.gold;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? AppColors.error : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.brown,
      ),
      onTap: onTap,
    );
  }
}