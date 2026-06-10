import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// More Screen - 100% Web Design Match
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                _buildQuickLinks(context),
                const SizedBox(height: 20),
                _buildSettingsSection(context),
                const SizedBox(height: 20),
                _buildAppInfo(),
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
          'المزيد',
          style: GoogleFonts.cairo(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'إعدادات وتطبيقات أخرى',
          style: GoogleFonts.cairo(
            fontSize: 14,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    final links = [
      {'icon': Icons.notifications_outlined, 'title': 'الإشعارات', 'subtitle': 'إدارة التنبيهات'},
      {'icon': Icons.star_outline_rounded, 'title': 'البطاقة اليومية', 'subtitle': 'إنشاء بطاقة مخصصة'},
      {'icon': Icons.share_outlined, 'title': 'مشاركة التطبيق', 'subtitle': 'شارك مع أصدقائك'},
      {'icon': Icons.help_outline_rounded, 'title': 'المساعدة', 'subtitle': 'تواصل معنا'},
    ];

    return Column(
      children: links.map((link) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF7),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0x3DC9A063), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A8A6B3D),
                blurRadius: 30,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(22),
              child: Padding(
                padding: const EdgeInsets.all(16),
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
                        link['icon'] as IconData,
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
                            link['title'] as String,
                            style: GoogleFonts.cairo(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.ink,
                            ),
                          ),
                          Text(
                            link['subtitle'] as String,
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: AppColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_left_rounded,
                      color: AppColors.gold,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
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
                Icons.settings_outlined,
                color: AppColors.goldDark,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'الإعدادات',
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingItem(
            icon: Icons.dark_mode_outlined,
            title: 'المظهر',
            subtitle: 'فاتح',
            onTap: () {},
          ),
          _buildSettingDivider(),
          _buildSettingItem(
            icon: Icons.language_outlined,
            title: 'اللغة',
            subtitle: 'العربية',
            onTap: () {},
          ),
          _buildSettingDivider(),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            title: 'التنبيهات',
            subtitle: 'مفعّلة',
            onTap: () {},
          ),
          _buildSettingDivider(),
          _buildSettingItem(
            icon: Icons.lock_outline,
            title: 'الخصوصية',
            subtitle: 'إدارة البيانات',
            onTap: () => context.pushNamed('privacy'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingDivider() {
    return Container(
      height: 1,
      color: AppColors.border,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: AppColors.goldDark, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink,
                  ),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_left_rounded,
                color: AppColors.muted,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'مواعيدك',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          Text(
            'الإصدار 1.0.0',
            style: GoogleFonts.cairo(
              fontSize: 13,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, AppColors.gold.withValues(alpha: 0.3), Colors.transparent],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink('الشروط', () {}),
              Container(width: 1, height: 16, color: AppColors.border, margin: const EdgeInsets.symmetric(horizontal: 16)),
              _buildFooterLink('الخصوصية', () {}),
              Container(width: 1, height: 16, color: AppColors.border, margin: const EdgeInsets.symmetric(horizontal: 16)),
              _buildFooterLink('الدعم', () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.gold,
        ),
      ),
    );
  }
}
