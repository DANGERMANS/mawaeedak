import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

/// صفحة الترحيب
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingItem> _pages = [
    _OnboardingItem(
      title: 'مواعيدك',
      description: 'كل مواعيدك في مكان واحد\nسهل الوصول والمنظمة',
      icon: Icons.calendar_month,
      color: AppColors.gold,
    ),
    _OnboardingItem(
      title: 'إدارة مالية',
      description: 'تتبع رواتبك ومصاريفك\nوخطط لميزانيتك',
      icon: Icons.account_balance_wallet,
      color: const Color(0xFF4A90A4),
    ),
    _OnboardingItem(
      title: 'مواقيت الصلاة',
      description: 'اعرف أوقات الصلاة\nمع عداد تنازلي',
      icon: Icons.mosque,
      color: const Color(0xFF7B68EE),
    ),
    _OnboardingItem(
      title: 'مراكز الخدمات',
      description: '8 مراكز خدمات حكومية\nفي تطبيق واحد',
      icon: Icons.business,
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
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => context.go('/auth'),
                child: const Text('تخطي'),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _OnboardingPage(item: page);
                },
              ),
            ),

            // Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.gold
                        : AppColors.gold.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('السابق'),
                      ),
                    )
                  else
                    const Expanded(child: SizedBox()),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < _pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context.go('/auth');
                        }
                      },
                      child: Text(
                        _currentPage < _pages.length - 1 ? 'التالي' : 'ابدأ الآن',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _OnboardingItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _OnboardingItem item;

  const _OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              item.icon,
              size: 80,
              color: item.color,
            ),
          ),
          const SizedBox(height: AppSpacing.xl * 2),
          Text(
            item.title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: item.color,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            item.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.8,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}