import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة القصص - الأدمن
class AdminStoryScreen extends StatefulWidget {
  const AdminStoryScreen({super.key});

  @override
  State<AdminStoryScreen> createState() => _AdminStoryScreenState();
}

class _AdminStoryScreenState extends State<AdminStoryScreen> {
  final List<_StoryItem> _stories = [
    _StoryItem(
      id: '1',
      title: 'قصة اليوم - الإيمان',
      content: 'الحمد لله على كل نعمه...',
      category: 'إيمان',
      date: '2026-06-10',
      isPublished: true,
    ),
    _StoryItem(
      id: '2',
      title: 'قصة اليوم - الحياة',
      content: 'الحياة مليئة بالدروس...',
      category: 'حياة',
      date: '2026-06-09',
      isPublished: true,
    ),
    _StoryItem(
      id: '3',
      title: 'قصة اليوم - التفاؤل',
      content: 'كن متفائلاً دائماً...',
      category: 'تفاؤل',
      date: '2026-06-08',
      isPublished: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة القصص'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStory,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return _StoryCard(
            story: story,
            onEdit: () => _editStory(story),
            onDelete: () => _deleteStory(story.id),
            onToggle: () => _toggleStory(story.id),
          );
        },
      ),
    );
  }

  void _addStory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إضافة قصة جديدة')),
    );
  }

  void _editStory(_StoryItem story) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تعديل ${story.title}')),
    );
  }

  void _deleteStory(String id) {
    setState(() => _stories.removeWhere((s) => s.id == id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف القصة')),
    );
  }

  void _toggleStory(String id) {
    setState(() {
      final index = _stories.indexWhere((s) => s.id == id);
      if (index != -1) {
        _stories[index] = _StoryItem(
          id: _stories[index].id,
          title: _stories[index].title,
          content: _stories[index].content,
          category: _stories[index].category,
          date: _stories[index].date,
          isPublished: !_stories[index].isPublished,
        );
      }
    });
  }
}

class _StoryItem {
  final String id;
  final String title;
  final String content;
  final String category;
  final String date;
  final bool isPublished;

  const _StoryItem({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
    required this.isPublished,
  });
}

class _StoryCard extends StatelessWidget {
  final _StoryItem story;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const _StoryCard({
    required this.story,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  Color get _categoryColor {
    switch (story.category) {
      case 'إيمان':
        return const Color(0xFF4A90A4);
      case 'حياة':
        return const Color(0xFF7B68EE);
      case 'تفاؤل':
        return const Color(0xFF2ECC71);
      default:
        return AppColors.brown;
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
                    color: _categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    story.category,
                    style: TextStyle(color: _categoryColor, fontSize: 12),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: story.isPublished
                        ? AppColors.success.withOpacity(0.1)
                        : AppColors.gold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    story.isPublished ? 'منشور' : 'مسودة',
                    style: TextStyle(
                      color: story.isPublished ? AppColors.success : AppColors.gold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(story.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              story.content,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Text(story.date, style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(
                    story.isPublished ? Icons.visibility_off : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: onToggle,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: AppColors.error),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}