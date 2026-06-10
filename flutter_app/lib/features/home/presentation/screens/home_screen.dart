import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/models/models.dart';
import '../../../../services/prayer_system.dart';
import '../../providers/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  PrayerData? prayerData;
  bool prayerLoading = true;
  String? prayerError;

  @override
  void initState() {
    super.initState();
    loadPrayerData();
  }

  Future<void> loadPrayerData() async {
    setState(() {
      prayerLoading = true;
      prayerError = null;
    });
    try {
      final data = await PrayerSystem().getPrayerData();
      if (!mounted) return;
      setState(() {
        prayerData = data;
        prayerLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        prayerData = null;
        prayerLoading = false;
        prayerError = 'تعذر تحديث مواقيت الصلاة. فعّل الموقع أو أعد المحاولة.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final financialEvents = ref.watch(financialHomeEventsProvider);
    final nearest = ref.watch(nearestFinancialEventProvider);
    final dailyMessage = ref.watch(dailyMessageProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),
                _buildHeader(),
                const SizedBox(height: AppSpacing.lg),
                _buildDailyMessageCard(dailyMessage),
                const SizedBox(height: AppSpacing.lg),
                _buildPrayerSection(),
                const SizedBox(height: AppSpacing.lg),
                _buildFinancialSection(financialEvents, nearest),
                const SizedBox(height: AppSpacing.lg),
                _buildQuickActions(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final now = DateTime.now();
    final greeting = now.hour < 12 ? 'صباح الخير' : 'مساء الخير';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(greeting, style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.ink, height: 1.2)),
            const SizedBox(height: AppSpacing.xs),
            Text('${now.day}/${now.month}/${now.year}', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted, height: 1.4)),
            Text('${now.day} هـ', style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.gold, height: 1.4)),
          ],
        ),
        GestureDetector(
          onTap: () => context.push('/notifications'),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(AppRadius.lg), boxShadow: AppShadows.card),
            child: const Icon(Icons.notifications_active_rounded, color: Colors.white, size: 26),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyMessageCard(String message) {
    return _brandCard(
      child: Row(
        children: [
          _iconBox(Icons.auto_awesome, AppColors.gold),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('رسالة اليوم', style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gold)),
                const SizedBox(height: 4),
                Text(message, style: GoogleFonts.cairo(fontSize: 15, color: AppColors.ink, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.mosque_rounded, 'مواقيت الصلاة'),
        const SizedBox(height: AppSpacing.md),
        _brandCard(child: _buildPrayerContent()),
      ],
    );
  }

  Widget _buildPrayerContent() {
    if (prayerLoading) {
      return Column(
        children: [
          const SizedBox(height: 8),
          const CircularProgressIndicator(color: AppColors.gold),
          const SizedBox(height: 12),
          Text('جاري تحديث المواقيت حسب موقعك', style: GoogleFonts.cairo(fontSize: 13, color: AppColors.muted)),
        ],
      );
    }
    if (prayerError != null) {
      return Column(
        children: [
          _iconBox(Icons.location_off_rounded, AppColors.error),
          const SizedBox(height: 12),
          Text(prayerError!, textAlign: TextAlign.center, style: GoogleFonts.cairo(fontSize: 14, color: AppColors.ink)),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: loadPrayerData, child: const Text('إعادة المحاولة')),
        ],
      );
    }

    final data = prayerData!;
    final ordered = ['الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('القادمة ${data.nextPrayer} بعد ${_formatDuration(data.countdownToNext)}', style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.gold)),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ordered.map((name) => _prayerChip(name, _formatTime(data.timings[name]))).toList(),
        ),
      ],
    );
  }

  Widget _prayerChip(String name, String time) {
    return Container(
      width: 92,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Column(
        children: [
          Text(name, style: GoogleFonts.cairo(fontSize: 12, color: AppColors.muted)),
          Text(time, style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.ink)),
        ],
      ),
    );
  }

  Widget _buildFinancialSection(List<FinancialEvent> events, FinancialEvent? nearest) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.account_balance_wallet_rounded, 'الرواتب والدعوم'),
        const SizedBox(height: AppSpacing.md),
        if (nearest != null) _buildNearestFinancialCard(nearest),
        if (nearest != null) const SizedBox(height: AppSpacing.sm),
        if (events.isEmpty) _buildEmptyFinancialState() else ...events.map(_buildFinancialItem),
      ],
    );
  }

  Widget _buildNearestFinancialCard(FinancialEvent event) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(gradient: AppColors.goldGradient, borderRadius: BorderRadius.circular(AppRadius.xxl), boxShadow: AppShadows.card),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: Colors.white, size: 28),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text('الأقرب: ${event.name}', style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white))),
          Text(_daysText(event.daysRemaining), style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildEmptyFinancialState() {
    return _brandCard(
      child: Center(child: Text('لا توجد عناصر مفعلة للعرض في الرئيسية', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted))),
    );
  }

  Widget _buildFinancialItem(FinancialEvent event) {
    final color = event.daysRemaining <= 2 ? AppColors.error : event.daysRemaining <= 5 ? AppColors.gold : AppColors.success;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
      child: Row(
        children: [
          _iconBox(_eventIcon(event.type), color),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(event.name, style: GoogleFonts.cairo(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.ink))),
          Text(_daysText(event.daysRemaining), style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _QuickActionButton(icon: Icons.style_rounded, label: 'البطاقة اليومية', color: AppColors.gold, onTap: () => context.pushNamed('daily-card'))),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _QuickActionButton(icon: Icons.calendar_month_rounded, label: 'المواعيد', color: AppColors.goldDark, onTap: () => context.goNamed('calendar'))),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: _QuickActionButton(icon: Icons.business_rounded, label: 'خدماتك', color: AppColors.success, onTap: () => context.goNamed('services'))),
      ],
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Row(children: [_iconBox(icon, AppColors.gold), const SizedBox(width: AppSpacing.sm), Text(title, style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.ink))]);
  }

  Widget _brandCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.xxl), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
      child: child,
    );
  }

  Widget _iconBox(IconData icon, Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(AppRadius.md)),
      child: Icon(icon, color: color, size: 24),
    );
  }

  IconData _eventIcon(String type) {
    switch (type) {
      case 'salary': return Icons.account_balance_wallet_rounded;
      case 'housing': return Icons.house_rounded;
      case 'social': return Icons.people_rounded;
      default: return Icons.volunteer_activism_rounded;
    }
  }

  String _daysText(int days) => days == 0 ? 'اليوم' : days == 1 ? 'غداً' : '$days يوم';

  String _formatTime(DateTime? time) {
    if (time == null) return '--:--';
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatDuration(Duration duration) {
    final safeDuration = duration.isNegative ? Duration.zero : duration;
    final hours = safeDuration.inHours;
    final minutes = safeDuration.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(AppRadius.xl), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
        child: Column(
          children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(AppRadius.md)), child: Icon(icon, color: color, size: 24)),
            const SizedBox(height: AppSpacing.sm),
            Text(label, style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.ink), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
