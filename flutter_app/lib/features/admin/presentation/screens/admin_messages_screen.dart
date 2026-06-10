import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الرسائل - الأدمن
class AdminMessagesScreen extends StatefulWidget {
  const AdminMessagesScreen({super.key});

  @override
  State<AdminMessagesScreen> createState() => _AdminMessagesScreenState();
}

class _AdminMessagesScreenState extends State<AdminMessagesScreen> {
  final List<_MessageItem> _messages = [
    _MessageItem(
      id: '1',
      sender: 'أحمد محمد',
      subject: 'استفسار عن الخدمة',
      body: 'أود الاستفسار عن خدمة السفر...',
      date: '2026-06-10 09:00',
      isRead: false,
    ),
    _MessageItem(
      id: '2',
      sender: 'فاطمة علي',
      subject: 'شكر وتقدير',
      body: 'شكراً على الخدمة الممتازة',
      date: '2026-06-09 14:30',
      isRead: true,
    ),
    _MessageItem(
      id: '3',
      sender: 'محمد خالد',
      subject: 'اقتراح',
      body: 'أقترح إضافة ميزة جديدة',
      date: '2026-06-08 11:00',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرسائل'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendBroadcast,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.send),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _MessageCard(
            message: message,
            onTap: () => _viewMessage(message),
          );
        },
      ),
    );
  }

  void _sendBroadcast() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إرسال رسالة جماعية')),
    );
  }

  void _viewMessage(_MessageItem message) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _MessageDetailSheet(message: message),
    );
  }
}

class _MessageItem {
  final String id;
  final String sender;
  final String subject;
  final String body;
  final String date;
  final bool isRead;

  const _MessageItem({
    required this.id,
    required this.sender,
    required this.subject,
    required this.body,
    required this.date,
    required this.isRead,
  });
}

class _MessageCard extends StatelessWidget {
  final _MessageItem message;
  final VoidCallback onTap;

  const _MessageCard({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: message.isRead ? null : AppColors.lightGold,
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.gold.withOpacity(0.1),
          child: Text(
            message.sender[0],
            style: const TextStyle(color: AppColors.gold),
          ),
        ),
        title: Text(
          message.subject,
          style: TextStyle(
            fontWeight: message.isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text('${message.sender} - ${message.date}'),
        trailing: message.isRead
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.gold,
                  shape: BoxShape.circle,
                ),
              ),
        onTap: onTap,
      ),
    );
  }
}

class _MessageDetailSheet extends StatelessWidget {
  final _MessageItem message;

  const _MessageDetailSheet({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.gold.withOpacity(0.1),
                child: Text(
                  message.sender[0],
                  style: const TextStyle(color: AppColors.gold),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(message.sender,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(message.date,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(message.subject,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          Text(message.body, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  label: const Text('إغلاق'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.reply),
                  label: const Text('رد'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}