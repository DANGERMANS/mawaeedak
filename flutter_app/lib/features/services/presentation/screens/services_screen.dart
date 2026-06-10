import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../home/providers/providers.dart';

class ServicesScreen extends ConsumerStatefulWidget {
  const ServicesScreen({super.key});

  @override
  ConsumerState<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends ConsumerState<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header
              _buildHeader(),
              const SizedBox(height: 24),
              // Service Sections Grid
              _buildServicesGrid(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'خدماتك',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'إدارة كل ما تحتاجه في مكان واحد',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      _ServiceItem(
        icon: '📅',
        title: 'نظم مواعيدك',
        description: 'إضافة وتعديل وحذف المواعيد',
        color: AppColors.gold,
        onTap: () => _showSectionDetail('appointments'),
      ),
      _ServiceItem(
        icon: '✈️',
        title: 'رحلاتي القادمة',
        description: 'إدارة رحلاتك وتجهيزاتها',
        color: AppColors.brown,
        onTap: () => _showSectionDetail('trips'),
      ),
      _ServiceItem(
        icon: '💬',
        title: 'الشكاوي والاقتراحات',
        description: 'أرسل شكواك أو اقتراحك',
        color: AppColors.info,
        onTap: () => _showSectionDetail('complaints'),
      ),
      _ServiceItem(
        icon: '🎉',
        title: 'قدم تهنئة لمن تريد',
        description: 'شارك التهاني مع أحبابك',
        color: AppColors.success,
        onTap: () => _showSectionDetail('greetings'),
      ),
      _ServiceItem(
        icon: '📞',
        title: 'اتصل بنا',
        description: 'تواصل معنا لأي استفسار',
        color: AppColors.gold,
        onTap: () => _showSectionDetail('contact'),
      ),
      _ServiceItem(
        icon: '📰',
        title: 'الأخبار',
        description: 'آخر الأخبار والمستجدات',
        color: AppColors.brown,
        onTap: () => _showSectionDetail('news'),
      ),
      _ServiceItem(
        icon: '💼',
        title: 'الوظائف',
        description: 'تصفح الوظائف المتاحة',
        color: AppColors.info,
        onTap: () => _showSectionDetail('jobs'),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _ServiceCard(service: service);
      },
    );
  }

  void _showSectionDetail(String section) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ServiceDetailSheet(section: section),
    );
  }
}

class _ServiceItem {
  final String icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _ServiceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: service.onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.brown.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: service.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(service.icon, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              service.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              service.description,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceDetailSheet extends StatefulWidget {
  final String section;

  const _ServiceDetailSheet({required this.section});

  @override
  State<_ServiceDetailSheet> createState() => _ServiceDetailSheetState();
}

class _ServiceDetailSheetState extends State<_ServiceDetailSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.paper,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  _getSectionIcon(widget.section),
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _getSectionTitle(widget.section),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.ink),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Content
          Expanded(
            child: _buildSectionContent(widget.section),
          ),
        ],
      ),
    );
  }

  String _getSectionIcon(String section) {
    switch (section) {
      case 'appointments':
        return '📅';
      case 'trips':
        return '✈️';
      case 'complaints':
        return '💬';
      case 'greetings':
        return '🎉';
      case 'contact':
        return '📞';
      case 'news':
        return '📰';
      case 'jobs':
        return '💼';
      default:
        return '📋';
    }
  }

  String _getSectionTitle(String section) {
    switch (section) {
      case 'appointments':
        return 'نظم مواعيدك';
      case 'trips':
        return 'رحلاتي القادمة';
      case 'complaints':
        return 'الشكاوي والاقتراحات';
      case 'greetings':
        return 'قدم تهنئة لمن تريد';
      case 'contact':
        return 'اتصل بنا';
      case 'news':
        return 'الأخبار';
      case 'jobs':
        return 'الوظائف';
      default:
        return '';
    }
  }

  Widget _buildSectionContent(String section) {
    // This would show the detail screen for each section
    // For now, show a placeholder
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildActionButton(
            icon: Icons.add,
            label: 'إضافة جديد',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('إضافة جديد')),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            icon: Icons.list,
            label: 'عرض الكل',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('عرض الكل')),
              );
            },
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            icon: Icons.search,
            label: 'بحث',
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('بحث')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.gold),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_left,
              color: AppColors.brown,
            ),
          ],
        ),
      ),
    );
  }
}