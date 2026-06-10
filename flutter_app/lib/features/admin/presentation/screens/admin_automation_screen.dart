import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الأتمتة - الأدمن
class AdminAutomationScreen extends StatefulWidget {
  const AdminAutomationScreen({super.key});

  @override
  State<AdminAutomationScreen> createState() => _AdminAutomationScreenState();
}

class _AdminAutomationScreenState extends State<AdminAutomationScreen> {
  final List<_AutomationItem> _automations = [
    _AutomationItem(
      id: '1',
      title: 'تذكير الصلاة',
      description: 'إرسال تذكير قبل كل صلاة بـ 15 دقيقة',
      trigger: 'scheduled',
      action: 'notification',
      isActive: true,
    ),
    _AutomationItem(
      id: '2',
      title: 'تذكير الراتب',
      description: 'إرسال إشعار عند حلول موعد الراتب',
      trigger: 'monthly',
      action: 'notification',
      isActive: true,
    ),
    _AutomationItem(
      id: '3',
      title: 'تذكير المواعيد',
      description: 'إرسال تذكير قبل الموعد بساعة',
      trigger: 'event',
      action: 'notification',
      isActive: false,
    ),
    _AutomationItem(
      id: '4',
      title: 'القصة اليومية',
      description: 'نشر قصة جديدة كل يوم',
      trigger: 'daily',
      action: 'story',
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأتمتة'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAutomation,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _automations.length,
        itemBuilder: (context, index) {
          final item = _automations[index];
          return _AutomationCard(
            item: item,
            onToggle: () => _toggleAutomation(item.id),
            onEdit: () => _editAutomation(item),
            onDelete: () => _deleteAutomation(item.id),
          );
        },
      ),
    );
  }

  void _toggleAutomation(String id) {
    setState(() {
      final index = _automations.indexWhere((a) => a.id == id);
      if (index != -1) {
        _automations[index] = _AutomationItem(
          id: _automations[index].id,
          title: _automations[index].title,
          description: _automations[index].description,
          trigger: _automations[index].trigger,
          action: _automations[index].action,
          isActive: !_automations[index].isActive,
        );
      }
    });
  }

  void _addAutomation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إضافة أتمتة جديدة')),
    );
  }

  void _editAutomation(_AutomationItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعديل الأتمتة')),
    );
  }

  void _deleteAutomation(String id) {
    setState(() => _automations.removeWhere((a) => a.id == id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف الأتمتة')),
    );
  }
}

class _AutomationItem {
  final String id;
  final String title;
  final String description;
  final String trigger;
  final String action;
  final bool isActive;

  const _AutomationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.trigger,
    required this.action,
    required this.isActive,
  });
}

class _AutomationCard extends StatelessWidget {
  final _AutomationItem item;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AutomationCard({
    required this.item,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  IconData get _triggerIcon {
    switch (item.trigger) {
      case 'scheduled':
        return Icons.schedule;
      case 'monthly':
        return Icons.calendar_month;
      case 'event':
        return Icons.event;
      case 'daily':
        return Icons.today;
      default:
        return Icons.auto_awesome;
    }
  }

  String get _triggerLabel {
    switch (item.trigger) {
      case 'scheduled':
        return 'مجدول';
      case 'monthly':
        return 'شهري';
      case 'event':
        return 'عند الحدث';
      case 'daily':
        return 'يومي';
      default:
        return item.trigger;
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_triggerIcon, size: 14, color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text(_triggerLabel,
                          style: const TextStyle(
                              color: AppColors.gold, fontSize: 12)),
                    ],
                  ),
                ),
                const Spacer(),
                Switch(
                  value: item.isActive,
                  onChanged: (_) => onToggle(),
                  activeColor: AppColors.gold,
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') onEdit();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                    const PopupMenuItem(
                      value: 'delete',
                      child:
                          Text('حذف', style: TextStyle(color: AppColors.error)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(item.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(item.description,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.bolt, size: 16, color: AppColors.brown),
                const SizedBox(width: 4),
                Text(
                  'إجراء: ${item.action}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}