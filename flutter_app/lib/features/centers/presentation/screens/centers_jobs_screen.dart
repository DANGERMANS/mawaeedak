import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات الوظائف
class CentersJobsScreen extends StatelessWidget {
  const CentersJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = List.generate(
      6,
      (i) => _JobItem(
        title: 'وظيفة ${i + 1}',
        company: 'شركة المثال',
        location: 'الرياض',
        salary: '${10000 + i * 1000} ر.س',
        type: i % 2 == 0 ? 'دوام كامل' : 'دوام جزئي',
        postedDate: '2026-06-${15 - i}',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('فرص العمل'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return _JobCard(job: job);
        },
      ),
    );
  }
}

class _JobItem {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String postedDate;

  const _JobItem({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.postedDate,
  });
}

class _JobCard extends StatelessWidget {
  final _JobItem job;

  const _JobCard({required this.job});

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
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2ECC71).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: Color(0xFF2ECC71),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        job.company,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _JobTag(icon: Icons.location_on, text: job.location),
                const SizedBox(width: AppSpacing.sm),
                _JobTag(icon: Icons.attach_money, text: job.salary),
                const SizedBox(width: AppSpacing.sm),
                _JobTag(icon: Icons.access_time, text: job.type),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Text(
                  job.postedDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                  child: const Text('تقدم الآن'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _JobTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _JobTag({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGold,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.brown),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.brown,
            ),
          ),
        ],
      ),
    );
  }
}