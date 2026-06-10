import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة القصص اليومية
class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_StoryItem> _stories = [
    _StoryItem(
      id: '1',
      title: 'قصة اليوم',
      content: '''الحمد لله الذي أنعم علينا بنعمة الإسلام، وأكرمنا بنعمة الإيمان، ووفقنا لما فيه خيرنا في الدنيا والآخرة.

قال تعالى: "وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ ۚ عَلَيْهِ تَوَكَّلْتُ وَإِلَيْهِ أُنِيبُ"''',
      date: '١٠ رمضان ١٤٤٥',
      category: 'إيمان',
      color: const Color(0xFF4A90A4),
    ),
    _StoryItem(
      id: '2',
      title: 'درس من الحياة',
      content: '''الحياة قصيرة جداً، فلا تضيعها في ما لا ينفعك. استغل وقتك في طاعة الله، وبِر والديك، وصلة رحمك.

قال رسول الله ﷺ: "لا_research_brief من的血脉 ولا Waller ولكن اخلص العمل واستقم".''',
      date: '٩ رمضان ١٤٤٥',
      category: 'حياة',
      color: const Color(0xFF7B68EE),
    ),
    _StoryItem(
      id: '3',
      title: 'التفاؤل والأمل',
      content: '''كن متفائلاً دائماً، فالله معك وهو ناصرك. لا تيأس من روح الله، ولا تحزن، إن الله معنا.

قال تعالى: "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا * إِنَّ مَعَ الْعُسْرِ يُسْرًا"''',
      date: '٨ رمضان ١٤٤٥',
      category: 'تفاؤل',
      color: const Color(0xFF2ECC71),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القصص اليومية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareStory,
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: _saveStory,
          ),
        ],
      ),
      body: Column(
        children: [
          // Story indicator
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: List.generate(
                _stories.length,
                (index) => Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index <= _currentPage
                          ? AppColors.gold
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Stories
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                final story = _stories[index];
                return _StoryPage(story: story);
              },
            ),
          ),

          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  OutlinedButton.icon(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    label: const Text('السابق'),
                  )
                else
                  const SizedBox(),
                Text(
                  '${_currentPage + 1} / ${_stories.length}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (_currentPage < _stories.length - 1)
                  ElevatedButton.icon(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    label: const Text('التالي'),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('إعادة'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareStory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم مشاركة القصة'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _saveStory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حفظ القصة'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

class _StoryItem {
  final String id;
  final String title;
  final String content;
  final String date;
  final String category;
  final Color color;

  const _StoryItem({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    required this.color,
  });
}

class _StoryPage extends StatelessWidget {
  final _StoryItem story;

  const _StoryPage({required this.story});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Category & Date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: story.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Text(
                  story.category,
                  style: TextStyle(
                    color: story.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                story.date,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Decorative line
          Container(
            width: 60,
            height: 4,
            decoration: BoxDecoration(
              color: story.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Title
          Text(
            story.title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: story.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Content
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: story.color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: story.color.withOpacity(0.2),
              ),
            ),
            child: Text(
              story.content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Decorative quote icon
          Icon(
            Icons.format_quote,
            size: 48,
            color: story.color.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}