import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Notification Screen - صفحة الإشعارات
class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});
  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _notifications = [
    {'icon': Icons.calendar_today_rounded, 'title': 'تذكير: راتب غداً', 'time': 'منذ ساعة', 'type': 'salary', 'unread': true},
    {'icon': Icons.event_rounded, 'title': 'موعد جديد: فحص طبي', 'time': 'منذ 3 ساعات', 'type': 'appointment', 'unread': true},
    {'icon': Icons.payment_rounded, 'title': 'فاتورة كهرباء مستحقة', 'time': 'أمس', 'type': 'bill', 'unread': false},
    {'icon': Icons.mosque_rounded, 'title': 'الظهر - 12:18', 'time': 'منذ يوم', 'type': 'prayer', 'unread': false},
    {'icon': Icons.notifications_active_rounded, 'title': 'تذكير: اجتماع', 'time': 'منذ 2 يوم', 'type': 'reminder', 'unread': false},
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
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabs(),
              Expanded(child: _buildNotificationsList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final unreadCount = _notifications.where((n) => n['unread'] == true).length;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCF7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0x3DC9A063)),
                boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 20, offset: Offset(0, 8))],
              ),
              child: const Icon(Icons.arrow_forward_rounded, color: AppColors.ink, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('الإشعارات', style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink)),
                Text('$unreadCount غير مقروءة', style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
              ],
            ),
          ),
          if (unreadCount > 0)
            GestureDetector(
              onTap: () => setState(() {
                for (var n in _notifications) {
                  n['unread'] = false;
                }
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('تحديد الكل كمقروء', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gold)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x3DC9A063)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.muted,
        labelStyle: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'الكل'),
          Tab(text: 'غير مقروءة'),
          Tab(text: 'مهمة'),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildList(_notifications),
        _buildList(_notifications.where((n) => n['unread'] == true).toList()),
        _buildList(_notifications.where((n) => n['type'] == 'salary' || n['type'] == 'appointment').toList()),
      ],
    );
  }

  Widget _buildList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_off_rounded, color: AppColors.gold.withValues(alpha: 0.5), size: 60),
            const SizedBox(height: 16),
            Text('لا توجد إشعارات', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.muted)),
          ],
        ),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final notification = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF7),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0x3DC9A063)),
          ),
          child: Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: _getNotificationColor(notification['type']).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_getNotificationIcon(notification['type']), color: _getNotificationColor(notification['type']), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(notification['title'], style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.ink)),
                        ),
                        if (notification['unread'] == true)
                          Container(
                            width: 8, height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.gold,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(notification['time'], style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'salary': return Icons.account_balance_wallet_rounded;
      case 'appointment': return Icons.event_rounded;
      case 'bill': return Icons.receipt_rounded;
      case 'prayer': return Icons.mosque_rounded;
      case 'reminder': return Icons.notifications_active_rounded;
      default: return Icons.notifications_rounded;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'salary': return AppColors.gold;
      case 'appointment': return AppColors.success;
      case 'bill': return AppColors.warning;
      case 'prayer': return AppColors.goldDark;
      default: return AppColors.info;
    }
  }
}
