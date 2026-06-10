import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_theme.dart';

/// [TITLE] - Service Screen
/// الحالة: Demo - يحتاج تطوير كامل
class SCREENScreen extends ConsumerWidget {
  const SCREENScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenTitle = '[TITLE]';
    final screenDesc = '[DESCRIPTION]';
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFCF7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0x3DC9A063)),
                          boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 20, offset: Offset(0, 8))],
                        ),
                        child: const Icon(Icons.arrow_forward_rounded, color: AppColors.ink, size: 22),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(screenTitle, style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: const Color(0x3DC9A063)),
                      boxShadow: const [BoxShadow(color: Color(0x1A8A6B3D), blurRadius: 30, offset: Offset(0, 12))],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
                          child: const Icon(Icons.construction_rounded, color: AppColors.gold, size: 40),
                        ),
                        const SizedBox(height: 20),
                        Text(screenTitle, style: GoogleFonts.cairo(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.ink)),
                        const SizedBox(height: 8),
                        Text('هذه الخدمة قيد التطوير', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted), textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: AppColors.paper, borderRadius: BorderRadius.circular(16)),
                          child: Text('سيتم إضافة هذه الخدمة قريباً.\nيمكنك تتبع التقدم في GitHub.', style: GoogleFonts.cairo(fontSize: 14, color: AppColors.muted, height: 1.6), textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
