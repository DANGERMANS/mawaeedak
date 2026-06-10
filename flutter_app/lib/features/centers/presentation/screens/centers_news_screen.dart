import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// خدمات الأخبار
class CentersNewsScreen extends StatelessWidget {
  const CentersNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final news = List.generate(
      5,
      (i) => _NewsItem(
        title: 'إعلان جديد رقم ${i + 1}',
        date: '2026-06-${10 - i}',
        summary: 'هذا نص إخباري توضيحي للمحتوى...',
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('آخر الأخبار'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          return _NewsCard(item: item);
        },
      ),
    );
  }
}

class _NewsItem {
  final String title;
  final String date;
  final String summary;

  const _NewsItem({
    required this.title,
    required this.date,
    required this.summary,
  });
}

class _NewsCard extends StatelessWidget {
  final _NewsItem item;

  const _NewsCard({required this.item});

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
                    color: const Color(0xFFFF6B6B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    'أخبار',
                    style: TextStyle(
                      color: const Color(0xFFFF6B6B),
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  item.date,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              item.summary,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}