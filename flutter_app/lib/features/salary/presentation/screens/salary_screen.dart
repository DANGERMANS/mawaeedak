import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../home/providers/providers.dart';

/// Salary Screen - الرواتب والدعم
class SalaryScreen extends ConsumerStatefulWidget {
  const SalaryScreen({super.key});
  @override
  ConsumerState<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends ConsumerState<SalaryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final financialEvents = ref.watch(financialEventsProvider);
    final upcomingEvents = financialEvents.where((e) => e.daysRemaining > 0).toList();
    final pastEvents = financialEvents.where((e) => e.daysRemaining <= 0).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabs(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildEventsList(upcomingEvents, 'القادمة'),
                    _buildEventsList(pastEvents, 'السابقة'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('الرواتب والدعم', style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.2)),
          const SizedBox(height: 4),
          Text('إدارة رواتبك والمستحقات المالية', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted)),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x3DC9A063)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(12)),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.muted,
        labelStyle: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        tabs: const [Tab(text: 'القادمة'), Tab(text: 'السابقة')],
      ),
    );
  }

  Widget _buildEventsList(List<FinancialEvent> events, String title) {
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined, color: AppColors.gold.withValues(alpha: 0.5), size: 60),
            const SizedBox(height: 16),
            Text('لا توجد مواعيد $title', style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.muted)),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) => _buildEventCard(events[index]),
    );
  }

  Widget _buildEventCard(FinancialEvent event) {
    final Icon = _getEventIcon(event.type);
    final daysText = event.daysRemaining > 0 ? '${event.daysRemaining} يوم' : 'تم';
    final daysColor = event.daysRemaining <= 2 ? AppColors.error : event.daysRemaining <= 5 ? AppColors.warning : AppColors.success;
    final progress = event.daysRemaining > 0 ? (1 - (event.daysRemaining / 30)).clamp(0.0, 1.0) : 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0x3DC9A063)),
        boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 30, offset: Offset(0, 12))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
                  child: Icon(Icon, color: AppColors.gold, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.name, style: GoogleFonts.cairo(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.ink)),
                      const SizedBox(height: 4),
                      Text(event.date, style: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: daysColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                  child: Text(daysText, style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w600, color: daysColor)),
                ),
              ],
            ),
          ),
          // Progress Arc
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.paper,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(22)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'salary': return Icons.account_balance_wallet_rounded;
      case 'support': return Icons.home_rounded;
      case 'housing': return Icons.house_rounded;
      case 'social': return Icons.people_rounded;
      case 'retirement': return Icons.elderly_rounded;
      case 'sanad': return Icons.health_and_safety_rounded;
      default: return Icons.calendar_today_rounded;
    }
  }
}
