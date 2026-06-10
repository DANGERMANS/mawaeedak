import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الشكاوى - الأدمن
class AdminComplaintsScreen extends StatefulWidget {
  const AdminComplaintsScreen({super.key});

  @override
  State<AdminComplaintsScreen> createState() => _AdminComplaintsScreenState();
}

class _AdminComplaintsScreenState extends State<AdminComplaintsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_ComplaintItem> _complaints = [
    _ComplaintItem(
      id: '1',
      title: 'شكوى في خدمة السفر',
      description: 'تأخر في معالجة الطلب',
      user: 'أحمد محمد',
      status: 'pending',
      date: '2026-06-08',
    ),
    _ComplaintItem(
      id: '2',
      title: 'شكوى في خدمة الدراسة',
      description: 'خطأ في البيانات',
      user: 'فاطمة علي',
      status: 'in_progress',
      date: '2026-06-07',
    ),
    _ComplaintItem(
      id: '3',
      title: 'شكوى في خدمة العمل',
      description: 'عدم الرد على الطلب',
      user: 'محمد خالد',
      status: 'resolved',
      date: '2026-06-05',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الشكاوى'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.gold,
          unselectedLabelColor: AppColors.brown,
          indicatorColor: AppColors.gold,
          tabs: const [
            Tab(text: 'جديدة'),
            Tab(text: 'قيد المراجعة'),
            Tab(text: 'تم الحل'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ComplaintsList(
            complaints: _complaints
                .where((c) => c.status == 'pending')
                .toList(),
            onResolve: _resolveComplaint,
          ),
          _ComplaintsList(
            complaints: _complaints
                .where((c) => c.status == 'in_progress')
                .toList(),
            onResolve: _resolveComplaint,
          ),
          _ComplaintsList(
            complaints: _complaints
                .where((c) => c.status == 'resolved')
                .toList(),
            onResolve: _resolveComplaint,
          ),
        ],
      ),
    );
  }

  void _resolveComplaint(String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حل الشكوى')),
    );
  }
}

class _ComplaintItem {
  final String id;
  final String title;
  final String description;
  final String user;
  final String status;
  final String date;

  const _ComplaintItem({
    required this.id,
    required this.title,
    required this.description,
    required this.user,
    required this.status,
    required this.date,
  });
}

class _ComplaintsList extends StatelessWidget {
  final List<_ComplaintItem> complaints;
  final Function(String) onResolve;

  const _ComplaintsList({
    required this.complaints,
    required this.onResolve,
  });

  @override
  Widget build(BuildContext context) {
    if (complaints.isEmpty) {
      return const Center(
        child: Text('لا توجد شكاوى'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];
        return _ComplaintCard(
          complaint: complaint,
          onResolve: () => onResolve(complaint.id),
        );
      },
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final _ComplaintItem complaint;
  final VoidCallback onResolve;

  const _ComplaintCard({
    required this.complaint,
    required this.onResolve,
  });

  Color get _statusColor {
    switch (complaint.status) {
      case 'pending':
        return AppColors.error;
      case 'in_progress':
        return AppColors.gold;
      case 'resolved':
        return AppColors.success;
      default:
        return AppColors.brown;
    }
  }

  String get _statusLabel {
    switch (complaint.status) {
      case 'pending':
        return 'جديدة';
      case 'in_progress':
        return 'قيد المراجعة';
      case 'resolved':
        return 'تم الحل';
      default:
        return complaint.status;
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
                    color: _statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(color: _statusColor, fontSize: 12),
                  ),
                ),
                const Spacer(),
                Text(complaint.date,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(complaint.title,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(complaint.description,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: AppColors.brown),
                const SizedBox(width: 4),
                Text(complaint.user,
                    style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                if (complaint.status != 'resolved')
                  TextButton(
                    onPressed: onResolve,
                    child: const Text('حل'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}