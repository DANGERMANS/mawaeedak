import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// طبقة البيانات - الأدمن
class AdminDataLayerScreen extends StatefulWidget {
  const AdminDataLayerScreen({super.key});

  @override
  State<AdminDataLayerScreen> createState() => _AdminDataLayerScreenState();
}

class _AdminDataLayerScreenState extends State<AdminDataLayerScreen> {
  String _selectedSource = 'supabase';
  bool _isConnected = true;
  String _lastSync = '2026-06-10 08:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طبقة البيانات'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Connection Status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _isConnected
                              ? AppColors.success
                              : AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        _isConnected ? 'متصل' : 'غير متصل',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'آخر مزامنة: $_lastSync',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton.icon(
                    onPressed: _syncData,
                    icon: const Icon(Icons.sync),
                    label: const Text('مزامنة الآن'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Data Sources
          Text(
            'مصادر البيانات',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          _DataSourceCard(
            title: 'Supabase',
            description: 'قاعدة البيانات الرئيسية',
            icon: Icons.storage,
            isSelected: _selectedSource == 'supabase',
            onTap: () => setState(() => _selectedSource = 'supabase'),
          ),
          _DataSourceCard(
            title: 'Gateway API',
            description: 'API الخارجي',
            icon: Icons.api,
            isSelected: _selectedSource == 'gateway',
            onTap: () => setState(() => _selectedSource = 'gateway'),
          ),
          _DataSourceCard(
            title: 'Mock Data',
            description: 'بيانات تجريبية',
            icon: Icons.data_object,
            isSelected: _selectedSource == 'mock',
            onTap: () => setState(() => _selectedSource = 'mock'),
          ),
          const SizedBox(height: AppSpacing.md),

          // Data Tables
          Text(
            'جداول البيانات',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          _DataTableCard(
            name: 'users',
            rows: 1234,
            lastUpdate: '2026-06-10',
          ),
          _DataTableCard(
            name: 'financial_events',
            rows: 567,
            lastUpdate: '2026-06-10',
          ),
          _DataTableCard(
            name: 'appointments',
            rows: 890,
            lastUpdate: '2026-06-09',
          ),
          _DataTableCard(
            name: 'notifications',
            rows: 2341,
            lastUpdate: '2026-06-10',
          ),
        ],
      ),
    );
  }

  void _syncData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('جاري المزامنة...')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _lastSync = '2026-06-10 10:30');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم المزامنة بنجاح'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });
  }
}

class _DataSourceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _DataSourceCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? AppColors.lightGold : null,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, color: AppColors.gold),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: AppColors.gold)
            : const Icon(Icons.circle_outlined),
        onTap: onTap,
      ),
    );
  }
}

class _DataTableCard extends StatelessWidget {
  final String name;
  final int rows;
  final String lastUpdate;

  const _DataTableCard({
    required this.name,
    required this.rows,
    required this.lastUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        title: Text(name),
        subtitle: Text('$_rows صف - آخر تحديث: $lastUpdate'),
        trailing: IconButton(
          icon: const Icon(Icons.refresh, color: AppColors.gold),
          onPressed: () {},
        ),
      ),
    );
  }
}