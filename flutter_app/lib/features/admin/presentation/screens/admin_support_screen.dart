import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// الدعم والمساعدة - الأدمن
class AdminSupportScreen extends StatefulWidget {
  const AdminSupportScreen({super.key});

  @override
  State<AdminSupportScreen> createState() => _AdminSupportScreenState();
}

class _AdminSupportScreenState extends State<AdminSupportScreen> {
  final List<_SupportTicket> _tickets = [
    _SupportTicket(
      id: '1',
      title: 'مشكلة في تسجيل الدخول',
      user: 'أحمد محمد',
      status: 'open',
      priority: 'high',
      date: '2026-06-10',
    ),
    _SupportTicket(
      id: '2',
      title: 'استفسار عن الخدمات',
      user: 'فاطمة علي',
      status: 'in_progress',
      priority: 'medium',
      date: '2026-06-09',
    ),
    _SupportTicket(
      id: '3',
      title: 'اقتراح ميزة جديدة',
      user: 'محمد خالد',
      status: 'closed',
      priority: 'low',
      date: '2026-06-08',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم والمساعدة'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _tickets.length,
        itemBuilder: (context, index) {
          final ticket = _tickets[index];
          return _SupportTicketCard(
            ticket: ticket,
            onTap: () => _viewTicket(ticket),
          );
        },
      ),
    );
  }

  void _viewTicket(_SupportTicket ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _TicketDetailSheet(ticket: ticket),
    );
  }
}

class _SupportTicket {
  final String id;
  final String title;
  final String user;
  final String status;
  final String priority;
  final String date;

  const _SupportTicket({
    required this.id,
    required this.title,
    required this.user,
    required this.status,
    required this.priority,
    required this.date,
  });
}

class _SupportTicketCard extends StatelessWidget {
  final _SupportTicket ticket;
  final VoidCallback onTap;

  const _SupportTicketCard({required this.ticket, required this.onTap});

  Color get _statusColor {
    switch (ticket.status) {
      case 'open':
        return AppColors.error;
      case 'in_progress':
        return AppColors.gold;
      case 'closed':
        return AppColors.success;
      default:
        return AppColors.brown;
    }
  }

  Color get _priorityColor {
    switch (ticket.priority) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.gold;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.brown;
    }
  }

  String get _statusLabel {
    switch (ticket.status) {
      case 'open':
        return 'مفتوح';
      case 'in_progress':
        return 'قيد المعالجة';
      case 'closed':
        return 'مغلق';
      default:
        return ticket.status;
    }
  }

  String get _priorityLabel {
    switch (ticket.priority) {
      case 'high':
        return 'عالية';
      case 'medium':
        return 'متوسطة';
      case 'low':
        return 'منخفضة';
      default:
        return ticket.priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _priorityColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(Icons.support_agent, color: _priorityColor),
        ),
        title: Text(ticket.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ticket.user),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _statusLabel,
                    style: TextStyle(color: _statusColor, fontSize: 10),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _priorityLabel,
                    style: TextStyle(color: _priorityColor, fontSize: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Text(ticket.date, style: Theme.of(context).textTheme.bodyMedium),
        onTap: onTap,
      ),
    );
  }
}

class _TicketDetailSheet extends StatelessWidget {
  final _SupportTicket ticket;

  const _TicketDetailSheet({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ticket.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          Text('المستخدم: ${ticket.user}',
              style: Theme.of(context).textTheme.bodyLarge),
          Text('التاريخ: ${ticket.date}',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          const Text('الرد:'),
          TextField(
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'اكتب ردك هنا...',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إغلاق'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('إرسال الرد'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}