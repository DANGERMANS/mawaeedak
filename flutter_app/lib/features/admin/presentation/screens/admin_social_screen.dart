import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الاجتماعي - الأدمن
class AdminSocialScreen extends StatefulWidget {
  const AdminSocialScreen({super.key});

  @override
  State<AdminSocialScreen> createState() => _AdminSocialScreenState();
}

class _AdminSocialScreenState extends State<AdminSocialScreen> {
  bool _notificationsEnabled = true;
  bool _emailEnabled = true;
  bool _smsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات الاجتماعية'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Notifications Settings
          _SettingsSection(
            title: 'الإشعارات',
            children: [
              _SettingsSwitch(
                title: 'إشعارات التطبيق',
                subtitle: 'تفعيل الإشعارات داخل التطبيق',
                value: _notificationsEnabled,
                onChanged: (v) => setState(() => _notificationsEnabled = v),
              ),
              _SettingsSwitch(
                title: 'إشعارات البريد',
                subtitle: 'إرسال إشعارات بالبريد الإلكتروني',
                value: _emailEnabled,
                onChanged: (v) => setState(() => _emailEnabled = v),
              ),
              _SettingsSwitch(
                title: 'رسائل SMS',
                subtitle: 'إرسال رسائل نصية',
                value: _smsEnabled,
                onChanged: (v) => setState(() => _smsEnabled = v),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Sharing Settings
          _SettingsSection(
            title: 'المشاركة',
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1DA1F2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(Icons.share, color: Color(0xFF1DA1F2)),
                ),
                title: const Text('Twitter'),
                subtitle: const Text('مشاركة القصص'),
                trailing: const Icon(Icons.check, color: AppColors.success),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4267B2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(Icons.facebook, color: Color(0xFF4267B2)),
                ),
                title: const Text('Facebook'),
                subtitle: const Text('مشاركة القصص'),
                trailing: const Icon(Icons.check, color: AppColors.success),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1306C).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(Icons.camera_alt, color: Color(0xFFE1306C)),
                ),
                title: const Text('Instagram'),
                subtitle: const Text('مشاركة القصص'),
                trailing: const Icon(Icons.close, color: AppColors.error),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // Contact Settings
          _SettingsSection(
            title: 'التواصل',
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(Icons.chat, color: AppColors.success),
                ),
                title: const Text('الدردشة'),
                subtitle: const Text('تفعيل الدردشة مع المستخدمين'),
                trailing: Switch(
                  value: true,
                  onChanged: (v) {},
                  activeColor: AppColors.gold,
                ),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(Icons.call, color: Color(0xFF25D366)),
                ),
                title: const Text('WhatsApp'),
                subtitle: const Text('رقم التواصل'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md, bottom: AppSpacing.sm),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        Card(child: Column(children: children)),
      ],
    );
  }
}

class _SettingsSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  const _SettingsSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.gold,
    );
  }
}