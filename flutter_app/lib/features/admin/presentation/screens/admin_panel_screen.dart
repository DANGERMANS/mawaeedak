import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  final _accessCodeController = TextEditingController();
  bool _isAuthenticated = false;
  bool _isLoading = false;

  // Admin sections
  int _selectedSection = 0;

  @override
  void dispose() {
    _accessCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return _buildAuthScreen();
    }

    return _buildAdminPanel();
  }

  Widget _buildAuthScreen() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5EFE4),
              Color(0xFFFAF7F2),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.gold,
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text('🔐', style: TextStyle(fontSize: 48)),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'لوحة المالك',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'أدخل رمز الدخول للمتابعة',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: _accessCodeController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'رمز الدخول',
                    filled: true,
                    fillColor: AppColors.cream,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _authenticate,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.gold,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'دخول',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    'العودة',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authenticate() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));

    // Simple demo auth (in production, use secure authentication)
    if (_accessCodeController.text == 'admin123') {
      setState(() {
        _isAuthenticated = true;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('رمز الدخول غير صحيح'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Widget _buildAdminPanel() {
    final sections = [
      _AdminSection(
        icon: '📝',
        title: 'إدارة الرسائل اليومية',
        items: ['رسالة اليوم', 'رسائل、宗教', 'رسائل تشجيعية'],
      ),
      _AdminSection(
        icon: '🎴',
        title: 'إدارة صور البطاقة',
        items: ['قوالب البطاقة', 'صور اليوم', 'خلفية الزخارف'],
      ),
      _AdminSection(
        icon: '💰',
        title: 'إدارة الرواتب والدعم',
        items: ['الرواتب', 'حساب المواطن', 'الدعم السكني', 'الضمان'],
      ),
      _AdminSection(
        icon: '🔗',
        title: 'إدارة المصادر الرسمية',
        items: ['روابط المواعيد', 'مصادر الزكاة', 'روابط الدعم'],
      ),
      _AdminSection(
        icon: '📰',
        title: 'إدارة الأخبار',
        items: ['الأخبار', 'التصنيفات', 'الإعلانات'],
      ),
      _AdminSection(
        icon: '💼',
        title: 'إدارة الوظائف',
        items: ['الوظائف', 'الشركات', 'التقديمات'],
      ),
      _AdminSection(
        icon: '💬',
        title: 'إدارة الشكاوي',
        items: ['الشكاوي', 'الاقتراحات', 'الردود'],
      ),
      _AdminSection(
        icon: '🎉',
        title: 'إدارة التهاني',
        items: ['قوالب التهاني', 'البطاقات', 'التخصيصات'],
      ),
      _AdminSection(
        icon: '🎨',
        title: 'إدارة الثيمات',
        items: ['الألوان', 'الخطوط', 'التخطيطات'],
      ),
      _AdminSection(
        icon: '⚙️',
        title: 'إعدادات التطبيق',
        items: ['عام', 'الخصوصية', 'التحديثات'],
      ),
      _AdminSection(
        icon: '🕌',
        title: 'حالة Prayer API',
        items: ['حالة الخادم', 'سجل الأخطاء', 'إحصائيات'],
      ),
      _AdminSection(
        icon: '📊',
        title: 'التقارير',
        items: ['تقارير المستخدمين', 'تقارير الاستخدام', 'الأرباح'],
      ),
      _AdminSection(
        icon: '💵',
        title: 'تكاليفك',
        items: ['الأهداف المالية', 'الأهداف غير المالية', 'المصروفات'],
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5EFE4),
              Color(0xFFFAF7F2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: sections.length,
                  itemBuilder: (context, index) {
                    final section = sections[index];
                    return _buildSectionCard(section);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => _isAuthenticated = false);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.logout, color: AppColors.ink),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'لوحة المالك',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, size: 16, color: AppColors.success),
                SizedBox(width: 4),
                Text(
                  'متصل',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(_AdminSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: ExpansionTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(section.icon, style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(
          section.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
        children: section.items
            .map((item) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  title: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_left,
                    color: AppColors.brown,
                    size: 20,
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('إدارة: $item')),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}

class _AdminSection {
  final String icon;
  final String title;
  final List<String> items;

  const _AdminSection({
    required this.icon,
    required this.title,
    required this.items,
  });
}