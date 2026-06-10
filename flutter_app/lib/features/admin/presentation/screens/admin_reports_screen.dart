import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// التقارير والإحصائيات - الأدمن
class AdminReportsScreen extends StatefulWidget {
  const AdminReportsScreen({super.key});

  @override
  State<AdminReportsScreen> createState() => _AdminReportsScreenState();
}

class _AdminReportsScreenState extends State<AdminReportsScreen> {
  String _selectedPeriod = 'شهر';

  final List<_ReportItem> _reports = [
    _ReportItem(
      id: '1',
      title: 'تقرير المستخدمين',
      description: 'إحصائيات المستخدمين النشطين',
      type: 'users',
      date: '2026-06-10',
    ),
    _ReportItem(
      id: '2',
      title: 'تقرير الأحداث',
      description: 'إحصائيات الأحداث والمواعيد',
      type: 'events',
      date: '2026-06-09',
    ),
    _ReportItem(
      id: '3',
      title: 'تقرير المالية',
      description: 'ملخص الإيرادات والمصروفات',
      type: 'finance',
      date: '2026-06-08',
    ),
    _ReportItem(
      id: '4',
      title: 'تقرير الإشعارات',
      description: 'معدل إرسال الإشعارات',
      type: 'notifications',
      date: '2026-06-07',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
      ),
      body: Column(
        children: [
          // Period Selector
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: DropdownButtonFormField<String>(
              value: _selectedPeriod,
              decoration: const InputDecoration(
                labelText: 'الفترة',
              ),
              items: ['يوم', 'أسبوع', 'شهر', 'سنة']
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (p) {
                if (p != null) setState(() => _selectedPeriod = p);
              },
            ),
          ),

          // Stats Overview
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatBox(value: '1.2K', label: 'مستخدمين'),
                _StatBox(value: '456', label: 'أحداث'),
                _StatBox(value: '89%', label: 'نسبة الأداء'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Reports List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _reports.length,
              itemBuilder: (context, index) {
                final report = _reports[index];
                return _ReportCard(report: report);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportItem {
  final String id;
  final String title;
  final String description;
  final String type;
  final String date;

  const _ReportItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
  });
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;

  const _StatBox({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.gold,
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  final _ReportItem report;

  const _ReportCard({required this.report});

  IconData get _icon {
    switch (report.type) {
      case 'users':
        return Icons.people;
      case 'events':
        return Icons.event;
      case 'finance':
        return Icons.attach_money;
      case 'notifications':
        return Icons.notifications;
      default:
        return Icons.description;
    }
  }

  Color get _color {
    switch (report.type) {
      case 'users':
        return const Color(0xFF4A90A4);
      case 'events':
        return AppColors.gold;
      case 'finance':
        return AppColors.success;
      case 'notifications':
        return const Color(0xFF7B68EE);
      default:
        return AppColors.brown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(_icon, color: _color),
        ),
        title: Text(report.title),
        subtitle: Text(report.description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(report.date,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            const Icon(Icons.download, color: AppColors.gold),
          ],
        ),
      ),
    );
  }
}