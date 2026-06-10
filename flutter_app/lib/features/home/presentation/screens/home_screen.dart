import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/models.dart';
import '../../../../services/prayer_system.dart';
import '../../providers/providers.dart';

/// Home Screen - Luxury Saudi Design
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  PrayerData? prayerData;

  @override
  void initState() {
    super.initState();
    loadPrayerData();
  }

  Future<void> loadPrayerData() async {
    final system = PrayerSystem();
    final data = await system.getPrayerData();
    if (!mounted) return;
    setState(() {
      prayerData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prayerTimes = ref.watch(prayerTimesProvider);
    final financialEvents = ref.watch(financialEventsProvider);
    final dailyMessage = ref.watch(dailyMessageProvider);
    final activePrayerTimes = prayerData == null ? prayerTimes : _prayerTimesFromData(prayerData!);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),
                // Header
                _buildHeader(),
                const SizedBox(height: AppSpacing.lg),
                // Daily Message
                _buildDailyMessageCard(dailyMessage),
                const SizedBox(height: AppSpacing.lg),
                // Prayer Times Section
                _buildPrayerSection(activePrayerTimes),
                const SizedBox(height: AppSpacing.lg),
                // Financial Events Section
                _buildFinancialSection(financialEvents),
                const SizedBox(height: AppSpacing.lg),
                // Quick Actions
                _buildQuickActions(context),
                const SizedBox(height: 100), // Bottom padding for nav bar
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
    final dayName = AppConstants.arabicDays[now.weekday % 7];
    final monthName = AppConstants.arabicMonths[now.month - 1];
    final hijriMonth = AppConstants.hijriMonths[now.month - 1];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: GoogleFonts.cairo(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
                height: 1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '$dayName، ${now.day} $monthName ${now.year}',
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.muted,
                height: 1.4,
              ),
            ),
            Text(
              '${now.day} $hijriMonth 1447 هـ',
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.gold,
                height: 1.4,
              ),
            ),
          ],
        ),
        // Logo Container
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.card,
          ),
          child: const Icon(
            Icons.calendar_month_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyMessageCard(String message) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رسالة اليوم',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gold,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    color: AppColors.ink,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerSection(PrayerTimes times) {
    final prayerSubtitle = prayerData == null
        ? 'جاري تحديث المواقيت حسب موقعك'
        : 'الآن ${prayerData!.currentPrayer}، القادمة ${prayerData!.nextPrayer} بعد ${_formatDuration(prayerData!.countdownToNext)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(
                Icons.mosque_rounded,
                color: AppColors.gold,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مواقيت الصلاة',
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                    height: 1.4,
                  ),
                ),
                Text(
                  prayerSubtitle,
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.muted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(color: AppColors.border, width: 1),
            boxShadow: AppShadows.card,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildPrayerTile('الفجر', times.fajr, Icons.nightlight_round, true)),
                  Expanded(child: _buildPrayerTile('الشروق', times.sunrise, Icons.wb_sunny_outlined, false)),
                  Expanded(child: _buildPrayerTile('الظهر', times.dhuhr, Icons.wb_sunny, false)),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, AppColors.gold.withValues(alpha: 0.3), Colors.transparent],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(child: _buildPrayerTile('العصر', times.asr, Icons.wb_sunny, false)),
                  Expanded(child: _buildPrayerTile('المغرب', times.maghrib, Icons.wb_twilight, false)),
                  Expanded(child: _buildPrayerTile('العشاء', times.isha, Icons.nights_stay_outlined, false)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerTile(String name, String time, IconData icon, bool isNight) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        children: [
          Icon(
            icon,
            color: isNight ? AppColors.goldDark : AppColors.gold,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: GoogleFonts.cairo(
              fontSize: 12,
              color: AppColors.muted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialSection(List<FinancialEvent> events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(
                Icons.account_balance_wallet_rounded,
                color: AppColors.success,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'المواعيد المالية',
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
                height: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (events.isEmpty)
          _buildEmptyFinancialState()
        else
          ...events.map((event) => _buildFinancialItem(event)),
      ],
    );
  }

  Widget _buildEmptyFinancialState() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(
              Icons.event_busy_rounded,
              color: AppColors.gold,
              size: 32,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'لا توجد مواعيد مالية',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
              height: 1.4,
            ),
          ),
          Text(
            'اربط قاعدة البيانات لإضافة المواعيد',
            style: GoogleFonts.cairo(
              fontSize: 13,
              color: AppColors.muted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialItem(FinancialEvent event) {
    final icon = AppConstants.financialTypes[event.type]?['icon'] ?? Icons.attach_money;
    final color = event.daysRemaining <= 2
        ? AppColors.error
        : event.daysRemaining <= 5
            ? AppColors.gold
            : AppColors.success;
    final daysText = event.daysRemaining == 0
        ? 'اليوم'
        : event.daysRemaining == 1
            ? 'غداً'
            : '${event.daysRemaining} يوم';

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.name,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                    height: 1.4,
                  ),
                ),
                if (event.amount != null)
                  Text(
                    '${event.amount} ر.س',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      color: AppColors.muted,
                      height: 1.4,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              daysText,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.goldDark.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: const Icon(
                Icons.flash_on_rounded,
                color: AppColors.goldDark,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'إجراءات سريعة',
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
                height: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.style_rounded,
                label: 'البطاقة اليومية',
                color: AppColors.gold,
                onTap: () => context.pushNamed('daily-card'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.calendar_month_rounded,
                label: 'المواعيد',
                color: AppColors.goldDark,
                onTap: () => context.goNamed('calendar'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.business_rounded,
                label: 'الخدمات',
                color: AppColors.success,
                onTap: () => context.goNamed('services'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  PrayerTimes _prayerTimesFromData(PrayerData data) {
    return PrayerTimes(
      fajr: _formatTime(data.timings['الفجر']),
      sunrise: _formatTime(data.sunrise),
      dhuhr: _formatTime(data.timings['الظهر']),
      asr: _formatTime(data.timings['العصر']),
      maghrib: _formatTime(data.timings['المغرب']),
      isha: _formatTime(data.timings['العشاء']),
    );
  }

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

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(color: AppColors.border, width: 1),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
