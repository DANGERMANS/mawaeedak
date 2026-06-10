import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3200), () {
      if (mounted) context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(AppRadius.xxl),
                      boxShadow: AppShadows.glass,
                    ),
                    child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 48),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('مواعيدك', style: GoogleFonts.cairo(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.ink)),
                  const SizedBox(height: AppSpacing.sm),
                  Text('صلِّ على رسول الله، عليه الصلاة والسلام', textAlign: TextAlign.center, style: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.goldDark)),
                  const SizedBox(height: AppSpacing.xl),
                  const CircularProgressIndicator(color: AppColors.gold),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
