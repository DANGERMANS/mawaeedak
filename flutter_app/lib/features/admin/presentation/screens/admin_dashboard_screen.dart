import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// لوحة تحكم الأدمن
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            _StatsSection(),
            const SizedBox(height: AppSpacing.lg),

            // Quick Actions
            Text(
              'إجراءات سريعة',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            _QuickActionsGrid(),

            const SizedBox(height: AppSpacing.lg),

            // Recent Activity
            Text(
              'النشاط الأخير',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            _RecentActivityList(),
          ],
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem(
        title: 'الأعضاء',
        value: '1,234',
        icon: Icons.people,
        color: const Color(0xFF4A90A4),
        change: '+12%',
      ),
      _StatItem(
        title: 'الأحداث',
        value: '456',
        icon: Icons.event,
        color: AppColors.gold,
        change: '+5%',
      ),
      _StatItem(
        title: 'الإشعارات',
        value: '89',
        icon: Icons.notifications,
        color: const Color(0xFF7B68EE),
        change: '-3%',
      ),
      _StatItem(
        title: 'الشكاوى',
        value: '23',
        icon: Icons.report_problem,
        color: AppColors.error,
        change: '-15%',
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.3,
      children: stats.map((stat) => _StatCard(stat: stat)).toList(),
    );
  }
}

class _StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;

  const _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
  });
}

class _StatCard extends StatelessWidget {
  final _StatItem stat;

  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    final isPositive = stat.change.startsWith('+');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: stat.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(stat.icon, color: stat.color, size: 20),
                ),
                Text(
                  stat.change,
                  style: TextStyle(
                    color: isPositive ? AppColors.success : AppColors.error,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  stat.title,
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

class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionItem(
        title: 'إدارة الأعضاء',
        icon: Icons.people_outline,
        color: const Color(0xFF4A90A4),
        onTap: () {},
      ),
      _ActionItem(
        title: 'إدارة الأحداث',
        icon: Icons.event_outlined,
        color: AppColors.gold,
        onTap: () {},
      ),
      _ActionItem(
        title: 'الشكاوى',
        icon: Icons.report_problem_outlined,
        color: AppColors.error,
        onTap: () {},
      ),
      _ActionItem(
        title: 'التقارير',
        icon: Icons.analytics_outlined,
        color: const Color(0xFF7B68EE),
        onTap: () {},
      ),
      _ActionItem(
        title: 'الإشعارات',
        icon: Icons.notifications_outlined,
        color: const Color(0xFF2ECC71),
        onTap: () {},
      ),
      _ActionItem(
        title: 'الإعدادات',
        icon: Icons.settings_outlined,
        color: AppColors.brown,
        onTap: () {},
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1,
      children: actions.map((action) => _ActionCard(action: action)).toList(),
    );
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _ActionCard extends StatelessWidget {
  final _ActionItem action;

  const _ActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: action.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(action.icon, color: action.color),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                action.title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentActivityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activities = [
      _ActivityItem(
        title: 'تم تسجيل عضو جديد',
        time: 'منذ 5 دقائق',
        icon: Icons.person_add,
        color: AppColors.success,
      ),
      _ActivityItem(
        title: 'تم إضافة حدث جديد',
        time: 'منذ ساعة',
        icon: Icons.add_circle,
        color: AppColors.gold,
      ),
      _ActivityItem(
        title: 'تم حل شكوى',
        time: 'منذ ساعتين',
        icon: Icons.check_circle,
        color: const Color(0xFF4A90A4),
      ),
      _ActivityItem(
        title: 'تم إرسال إشعار',
        time: 'منذ 3 ساعات',
        icon: Icons.notifications,
        color: const Color(0xFF7B68EE),
      ),
    ];

    return Column(
      children: activities
          .map((activity) => _ActivityCard(activity: activity))
          .toList(),
    );
  }
}

class _ActivityItem {
  final String title;
  final String time;
  final IconData icon;
  final Color color;

  const _ActivityItem({
    required this.title,
    required this.time,
    required this.icon,
    required this.color,
  });
}

class _ActivityCard extends StatelessWidget {
  final _ActivityItem activity;

  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: activity.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(activity.icon, color: activity.color, size: 20),
        ),
        title: Text(activity.title),
        subtitle: Text(activity.time),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.brown,
        ),
      ),
    );
  }
}