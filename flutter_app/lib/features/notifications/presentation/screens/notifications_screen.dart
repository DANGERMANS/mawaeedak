import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة الإشعارات
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      id: '1',
      title: 'تذكير: صلاة الظهر',
      body: 'حان وقت صلاة الظهر - 12:10 م',
      time: 'منذ 5 دقائق',
      isRead: false,
      type: _NotificationType.prayer,
    ),
    _NotificationItem(
      id: '2',
      title: 'راتبك لهذا الشهر',
      body: 'تم إيداع راتب شهر يونيو - 15,000 ر.س',
      time: 'منذ ساعة',
      isRead: false,
      type: _NotificationType.finance,
    ),
    _NotificationItem(
      id: '3',
      title: 'موعد جديد',
      body: 'لديك موعد غداً مع الطبيب',
      time: 'منذ 3 ساعات',
      isRead: true,
      type: _NotificationType.appointment,
    ),
    _NotificationItem(
      id: '4',
      title: 'قصة اليوم',
      body: 'تمت إضافة قصة جديدة - قصة اليوم',
      time: 'منذ يوم',
      isRead: true,
      type: _NotificationType.story,
    ),
    _NotificationItem(
      id: '5',
      title: 'تحديث في التطبيق',
      body: 'يتوفر تحديث جديد للتطبيق',
      time: 'منذ يومين',
      isRead: true,
      type: _NotificationType.system,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإشعارات'),
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text('تحديد الكل كمقروء'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return _NotificationCard(
            notification: notification,
            onTap: () => _markAsRead(notification.id),
            onDismiss: () => _deleteNotification(notification.id),
          );
        },
      ),
    );
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        _notifications[index] = _NotificationItem(
          id: _notifications[index].id,
          title: _notifications[index].title,
          body: _notifications[index].body,
          time: _notifications[index].time,
          isRead: true,
          type: _notifications[index].type,
        );
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _NotificationItem(
          id: _notifications[i].id,
          title: _notifications[i].title,
          body: _notifications[i].body,
          time: _notifications[i].time,
          isRead: true,
          type: _notifications[i].type,
        );
      }
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n.id == id);
    });
  }
}

enum _NotificationType {
  prayer,
  finance,
  appointment,
  story,
  system,
}

class _NotificationItem {
  final String id;
  final String title;
  final String body;
  final String time;
  final bool isRead;
  final _NotificationType type;

  const _NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.type,
  });
}

class _NotificationCard extends StatelessWidget {
  final _NotificationItem notification;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onDismiss,
  });

  IconData get _icon {
    switch (notification.type) {
      case _NotificationType.prayer:
        return Icons.mosque;
      case _NotificationType.finance:
        return Icons.attach_money;
      case _NotificationType.appointment:
        return Icons.calendar_today;
      case _NotificationType.story:
        return Icons.auto_stories;
      case _NotificationType.system:
        return Icons.settings;
    }
  }

  Color get _iconColor {
    switch (notification.type) {
      case _NotificationType.prayer:
        return const Color(0xFF4A90A4);
      case _NotificationType.finance:
        return AppColors.success;
      case _NotificationType.appointment:
        return AppColors.gold;
      case _NotificationType.story:
        return const Color(0xFF7B68EE);
      case _NotificationType.system:
        return AppColors.brown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        color: AppColors.error,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        color: notification.isRead ? null : AppColors.lightGold,
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(_icon, color: _iconColor),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(left: AppSpacing.sm),
                              decoration: const BoxDecoration(
                                color: AppColors.gold,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              notification.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: notification.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.body,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        notification.time,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                          color: AppColors.brown,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}