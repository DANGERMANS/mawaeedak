import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/providers/providers.dart';

/// Calendar Screen - 100% Web Design Match
class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final financialEvents = ref.watch(financialEventsProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 20),
                _buildCalendarView(),
                const SizedBox(height: 20),
                _buildUpcomingSection(financialEvents),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التقويم',
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'جدول مواعيدك الشهرية',
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x3DC9A063), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A8A6B3D),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          // Month Navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_rounded, color: AppColors.gold),
              ),
              Text(
                'يونيو 2026',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.chevron_left_rounded, color: AppColors.gold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Week Days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['أحد', 'إثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: 35,
            itemBuilder: (context, index) {
              final day = index - 2;
              if (day < 1 || day > 30) {
                return const SizedBox();
              }
              final today = DateTime.now().day;
              final isToday = day == today;
              return Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isToday ? AppColors.gold : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: isToday ? FontWeight.w800 : FontWeight.w400,
                      color: isToday ? Colors.white : AppColors.ink,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSection(List events) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: const Color(0x3DC9A063), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A8A6B3D),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_rounded,
                color: AppColors.gold,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'المواعيد القادمة',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (events.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCF7),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0x3DC9A063)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.gold,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'لا توجد مواعيد',
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'اربط قاعدة البيانات لإضافة المواعيد',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      color: AppColors.muted,
                    ),
                  ),
                ],
              ),
            )
          else
            ...events.take(5).map((e) => _buildEventItem(e)),
        ],
      ),
    );
  }

  Widget _buildEventItem(dynamic event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x3DC9A063)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_rounded,
              color: AppColors.gold,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
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
                  ),
                ),
                if (event.amount != null)
                  Text(
                    '${event.amount} ر.س',
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      color: AppColors.muted,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${event.daysRemaining} يوم',
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.gold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
