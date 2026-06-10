import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_theme.dart';

class AthkarScreen extends ConsumerWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _SimpleServiceScreen(title: 'الأذكار', description: 'أذكار الصباح والمساء بتصميم مواعيدك.', icon: Icons.mosque_rounded);
  }
}

class _SimpleServiceScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _SimpleServiceScreen({required this.title, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(children: [IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_forward_rounded)), Expanded(child: Text(title, style: GoogleFonts.cairo(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.ink)))]),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border), boxShadow: AppShadows.card),
                child: Column(children: [Icon(icon, color: AppColors.gold, size: 48), const SizedBox(height: 16), Text(description, textAlign: TextAlign.center, style: GoogleFonts.cairo(fontSize: 15, color: AppColors.muted, height: 1.6)), const SizedBox(height: 16), ElevatedButton(onPressed: () {}, child: const Text('حفظ'))]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
