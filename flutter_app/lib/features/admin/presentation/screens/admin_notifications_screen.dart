import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الإشعارات - الأدمن
class AdminNotificationsScreen extends StatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  State<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState
    extends State<AdminNotificationsScreen> {
  final List<_NotificationTemplate> _templates = [
    _NotificationTemplate(
      id: '1',
      title: 'تذكير الصلاة',
      body: 'حان وقت صلاة {{prayer}}',
      type: 'prayer',
      isActive: true,
    ),
    _NotificationTemplate(
      id: '2',
      title: 'تذكير الراتب',
      body: 'تم إيداع راتب {{amount}} ر.س',
      type: 'finance',
      isActive: true,
    ),
    _NotificationTemplate(
      id: '3',
      title: 'موعد قريب',
      body: 'لديك موعد {{title}} بعد {{time}} ساعة',
      type: 'appointment',
      isActive: false,
    ),
    _NotificationTemplate(
      id: '4',
      title: 'قصة جديدة',
      body: 'تمت إضافة قصة "{{story_title}}"',
      type: 'story',
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الإشعارات'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTemplate,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _templates.length,
        itemBuilder: (context, index) {
          final template = _templates[index];
          return _NotificationTemplateCard(
            template: template,
            onToggle: () => _toggleTemplate(template.id),
            onEdit: () => _editTemplate(template),
            onDelete: () => _deleteTemplate(template.id),
            onSendTest: () => _sendTestNotification(template),
          );
        },
      ),
    );
  }

  void _createTemplate() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إنشاء قالب جديد')),
    );
  }

  void _toggleTemplate(String id) {
    setState(() {
      final index = _templates.indexWhere((t) => t.id == id);
      if (index != -1) {
        _templates[index] = _NotificationTemplate(
          id: _templates[index].id,
          title: _templates[index].title,
          body: _templates[index].body,
          type: _templates[index].type,
          isActive: !_templates[index].isActive,
        );
      }
    });
  }

  void _editTemplate(_NotificationTemplate template) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعديل القالب')),
    );
  }

  void _deleteTemplate(String id) {
    setState(() => _templates.removeWhere((t) => t.id == id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف القالب')),
    );
  }

  void _sendTestNotification(_NotificationTemplate template) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إرسال إشعار تجريبي')),
    );
  }
}

class _NotificationTemplate {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool isActive;

  const _NotificationTemplate({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isActive,
  });
}

class _NotificationTemplateCard extends StatelessWidget {
  final _NotificationTemplate template;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSendTest;

  const _NotificationTemplateCard({
    required this.template,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onSendTest,
  });

  Color get _typeColor {
    switch (template.type) {
      case 'prayer':
        return const Color(0xFF4A90A4);
      case 'finance':
        return AppColors.success;
      case 'appointment':
        return AppColors.gold;
      case 'story':
        return const Color(0xFF7B68EE);
      default:
        return AppColors.brown;
    }
  }

  IconData get _typeIcon {
    switch (template.type) {
      case 'prayer':
        return Icons.mosque;
      case 'finance':
        return Icons.attach_money;
      case 'appointment':
        return Icons.calendar_today;
      case 'story':
        return Icons.auto_stories;
      default:
        return Icons.notifications;
    }
  }

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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _typeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(_typeIcon, color: _typeColor),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(template.title,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(template.type,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                Switch(
                  value: template.isActive,
                  onChanged: (_) => onToggle(),
                  activeColor: AppColors.gold,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.lightGold,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                template.body,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onSendTest,
                  icon: const Icon(Icons.send, size: 18),
                  label: const Text('اختبار'),
                ),
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('تعديل'),
                ),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, size: 18, color: AppColors.error),
                  label: const Text('حذف',
                      style: TextStyle(color: AppColors.error)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}