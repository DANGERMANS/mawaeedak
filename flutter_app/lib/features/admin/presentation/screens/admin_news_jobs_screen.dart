import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الأخبار والوظائف - الأدمن
class AdminNewsJobsScreen extends StatefulWidget {
  const AdminNewsJobsScreen({super.key});

  @override
  State<AdminNewsJobsScreen> createState() => _AdminNewsJobsScreenState();
}

class _AdminNewsJobsScreenState extends State<AdminNewsJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<_NewsItem> _news = [
    _NewsItem(
      id: '1',
      title: 'إعلان جديد عن الخدمات',
      content: 'تم إضافة خدمات جديدة...',
      date: '2026-06-10',
      isPublished: true,
    ),
    _NewsItem(
      id: '2',
      title: 'تحديث في التطبيق',
      content: 'يتوفر تحديث جديد...',
      date: '2026-06-08',
      isPublished: false,
    ),
  ];

  final List<_JobItem> _jobs = [
    _JobItem(
      id: '1',
      title: 'مهندس برمجيات',
      company: 'شركة التقنية',
      location: 'الرياض',
      date: '2026-06-10',
      isActive: true,
    ),
    _JobItem(
      id: '2',
      title: 'محاسب',
      company: 'شركة المالية',
      location: 'جدة',
      date: '2026-06-08',
      isActive: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('الأخبار والوظائف'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.gold,
          unselectedLabelColor: AppColors.brown,
          indicatorColor: AppColors.gold,
          tabs: const [
            Tab(text: 'الأخبار'),
            Tab(text: 'الوظائف'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(context),
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _NewsList(news: _news),
          _JobsList(jobs: _jobs),
        ],
      ),
    );
  }

  void _addItem(BuildContext context) {
    if (_tabController.index == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('إضافة خبر جديد')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('إضافة وظيفة جديدة')),
      );
    }
  }
}

class _NewsItem {
  final String id;
  final String title;
  final String content;
  final String date;
  final bool isPublished;

  const _NewsItem({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isPublished,
  });
}

class _JobItem {
  final String id;
  final String title;
  final String company;
  final String location;
  final String date;
  final bool isActive;

  const _JobItem({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.date,
    required this.isActive,
  });
}

class _NewsList extends StatelessWidget {
  final List<_NewsItem> news;

  const _NewsList({required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: news.length,
      itemBuilder: (context, index) {
        final item = news[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: const Icon(Icons.newspaper, color: Color(0xFFFF6B6B)),
            ),
            title: Text(item.title),
            subtitle: Text(item.date),
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: item.isPublished
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.gold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                item.isPublished ? 'منشور' : 'مسودة',
                style: TextStyle(
                  color: item.isPublished ? AppColors.success : AppColors.gold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _JobsList extends StatelessWidget {
  final List<_JobItem> jobs;

  const _JobsList({required this.jobs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final item = jobs[index];
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2ECC71).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: const Icon(Icons.work, color: Color(0xFF2ECC71)),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.title,
                              style:
                                  Theme.of(context).textTheme.titleMedium),
                          Text(item.company,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: item.isActive
                            ? AppColors.success.withOpacity(0.1)
                            : AppColors.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        item.isActive ? 'نشط' : 'منتهي',
                        style: TextStyle(
                          color:
                              item.isActive ? AppColors.success : AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: AppColors.brown),
                    const SizedBox(width: 4),
                    Text(item.location,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Text(item.date,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}