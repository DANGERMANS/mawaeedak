import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

/// تخطيط الأدمن الرئيسي
class AdminLayoutScreen extends StatelessWidget {
  const AdminLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الأدمن'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/admin/notifications'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/admin/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _QuickStatCard(
                    title: 'الأعضاء',
                    value: '1,234',
                    icon: Icons.people,
                    color: const Color(0xFF4A90A4),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _QuickStatCard(
                    title: 'الأحداث',
                    value: '456',
                    icon: Icons.event,
                    color: AppColors.gold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _QuickStatCard(
                    title: 'الشكاوى',
                    value: '23',
                    icon: Icons.report_problem,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _QuickStatCard(
                    title: 'وقت التشغيل',
                    value: '99.9%',
                    icon: Icons.verified,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Navigation Grid
            Text(
              'إدارة المحتوى',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1,
              children: [
                _NavCard(
                  title: 'الأعضاء',
                  icon: Icons.people_outline,
                  color: const Color(0xFF4A90A4),
                  onTap: () => context.push('/admin/members'),
                ),
                _NavCard(
                  title: 'الأحداث',
                  icon: Icons.event_outlined,
                  color: AppColors.gold,
                  onTap: () => context.push('/admin/events'),
                ),
                _NavCard(
                  title: 'المالية',
                  icon: Icons.attach_money,
                  color: AppColors.success,
                  onTap: () => context.push('/admin/finance'),
                ),
                _NavCard(
                  title: 'الشكاوى',
                  icon: Icons.report_problem_outlined,
                  color: AppColors.error,
                  onTap: () => context.push('/admin/complaints'),
                ),
                _NavCard(
                  title: 'الأخبار',
                  icon: Icons.newspaper,
                  color: const Color(0xFFFF6B6B),
                  onTap: () => context.push('/admin/news'),
                ),
                _NavCard(
                  title: 'الوظائف',
                  icon: Icons.work_outline,
                  color: const Color(0xFF2ECC71),
                  onTap: () => context.push('/admin/jobs'),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // System Management
            Text(
              'إدارة النظام',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1,
              children: [
                _NavCard(
                  title: 'الأتمتة',
                  icon: Icons.auto_awesome,
                  color: const Color(0xFF7B68EE),
                  onTap: () => context.push('/admin/automation'),
                ),
                _NavCard(
                  title: 'الإشعارات',
                  icon: Icons.notifications_outlined,
                  color: const Color(0xFFFFB347),
                  onTap: () => context.push('/admin/notifications'),
                ),
                _NavCard(
                  title: 'القصص',
                  icon: Icons.auto_stories,
                  color: const Color(0xFF4A90A4),
                  onTap: () => context.push('/admin/story'),
                ),
                _NavCard(
                  title: 'الصلاحيات',
                  icon: Icons.security,
                  color: AppColors.brown,
                  onTap: () => context.push('/admin/permissions'),
                ),
                _NavCard(
                  title: 'المظاهر',
                  icon: Icons.palette,
                  color: const Color(0xFFFF69B4),
                  onTap: () => context.push('/admin/themes'),
                ),
                _NavCard(
                  title: 'الدعم',
                  icon: Icons.support_agent,
                  color: const Color(0xFF20B2AA),
                  onTap: () => context.push('/admin/support'),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xl),

            // Tools
            Text(
              'الأدوات',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1,
              children: [
                _NavCard(
                  title: 'التقارير',
                  icon: Icons.analytics,
                  color: const Color(0xFF7B68EE),
                  onTap: () => context.push('/admin/reports'),
                ),
                _NavCard(
                  title: 'البيانات',
                  icon: Icons.storage,
                  color: AppColors.gold,
                  onTap: () => context.push('/admin/data'),
                ),
                _NavCard(
                  title: 'الدليل',
                  icon: Icons.help_outline,
                  color: const Color(0xFF4A90A4),
                  onTap: () => context.push('/admin/guide'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _QuickStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _NavCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}