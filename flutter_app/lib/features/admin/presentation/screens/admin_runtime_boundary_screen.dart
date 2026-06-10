import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// حد الأخطاء - الأدمن
class AdminRuntimeBoundaryScreen extends StatefulWidget {
  const AdminRuntimeBoundaryScreen({super.key});

  @override
  State<AdminRuntimeBoundaryScreen> createState() =>
      _AdminRuntimeBoundaryScreenState();
}

class _AdminRuntimeBoundaryScreenState
    extends State<AdminRuntimeBoundaryScreen> {
  final List<_ErrorLog> _errors = [
    _ErrorLog(
      id: '1',
      message: 'خطأ في الاتصال بقاعدة البيانات',
      type: 'error',
      date: '2026-06-10 10:30',
      count: 5,
    ),
    _ErrorLog(
      id: '2',
      message: 'تحذير: بطء الاستجابة',
      type: 'warning',
      date: '2026-06-10 09:15',
      count: 12,
    ),
    _ErrorLog(
      id: '3',
      message: 'خطأ: فشل المصادقة',
      type: 'error',
      date: '2026-06-09 18:45',
      count: 3,
    ),
  ];

  bool _autoReport = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حدود الأخطاء'),
      ),
      body: Column(
        children: [
          // Settings
          Card(
            margin: const EdgeInsets.all(AppSpacing.md),
            child: SwitchListTile(
              title: const Text('التقرير التلقائي'),
              subtitle: const Text('إرسال تقرير عند حدوث أخطاء'),
              value: _autoReport,
              onChanged: (v) => setState(() => _autoReport = v),
              secondary: const Icon(Icons.report),
            ),
          ),

          // Error Summary
          Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ErrorStatBox(
                  value: '20',
                  label: 'أخطاء اليوم',
                  color: AppColors.error,
                ),
                _ErrorStatBox(
                  value: '45',
                  label: 'تحذيرات',
                  color: AppColors.gold,
                ),
                _ErrorStatBox(
                  value: '99.9%',
                  label: 'وقت التشغيل',
                  color: AppColors.success,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Error List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _errors.length,
              itemBuilder: (context, index) {
                final error = _errors[index];
                return _ErrorCard(error: error);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorLog {
  final String id;
  final String message;
  final String type;
  final String date;
  final int count;

  const _ErrorLog({
    required this.id,
    required this.message,
    required this.type,
    required this.date,
    required this.count,
  });
}

class _ErrorStatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _ErrorStatBox({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color,
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final _ErrorLog error;

  const _ErrorCard({required this.error});

  IconData get _icon {
    switch (error.type) {
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  Color get _color {
    switch (error.type) {
      case 'error':
        return AppColors.error;
      case 'warning':
        return AppColors.gold;
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
        title: Text(error.message),
        subtitle: Text(error.date),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: _color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            '${error.count}x',
            style: TextStyle(color: _color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}